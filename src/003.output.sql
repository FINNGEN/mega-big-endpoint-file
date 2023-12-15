WITH
    -- Handling 2-endpoint statistics
    out_freg_surv AS
    (
        SELECT
            prior AS endpoint1,
            outcome AS endpoint2,
            nindivs_prior_outcome AS `freg_surv.fr-r11.nindivs_endpoint1_then_endpoint2`,
            prior_hr AS `freg_surv.fr-r11.endpoint1_hr`,
            prior_ci_lower AS `freg_surv.fr-r11.endpoint1_hr_ci_lower`,
            prior_ci_upper AS `freg_surv.fr-r11.endpoint1_hr_ci_upper`,
            prior_pval AS `freg_surv.fr-r11.endpoint1_hr_pval`
        FROM freg_surv
    ),
    out_ldsc_summary AS
    (
        SELECT
            endpoint1,
            endpoint2,
            rg AS `ldsc_summary.fg-r12.rg`,
            rg_pval AS `ldsc_summary.fg-r12.rg_pval`,
            rg_se AS `ldsc_summary.fg-r12.rg_se`,
            `converged?` AS `ldsc_summary.fg-r12.converged?`
        FROM ldsc_summary
    ),
    out_pheno_corr AS
    (
        SELECT
            endpoint1,
            endpoint2,
            jaccard_index AS `pheno_corr.fg-r12.jaccard_index`,
            case_overlap_N AS `pheno_corr.fg-r12.case_overlap_N`,
            overlap_coef AS `pheno_corr.fg-r12.overlap_coef`,
            `is_subset?` AS `pheno_corr.fg-r12.is_subset?`
        FROM pheno_corr
    ),
    out_autoreport AS
    (
        SELECT
            endpoint1,
            endpoint2,
            `n_gws_hits.endpoint1` AS `autoreport.fg-r12.n_gws_hits.endpoint1`,
            `n_gws_hits.endpoint2` AS `autoreport.fg-r12.n_gws_hits.endpoint2`,
            overlap_same_doe AS `autoreport.fg-r12.overlap_same_doe`,
            overlap_opposite_doe AS `autoreport.fg-r12.overlap_opposite_doe`
        FROM autoreport
    ),

    -- Handling 1-endpoint statistics
    definition1 AS (
        SELECT
            name AS endpoint1,
            longname AS `endpoint_definitions.fg-r12.longname.endpoint1`,
            `is_core?` AS `endpoint_definitions.fg-r12.is_core?.endpoint1`
        FROM endpoint_definitions
    ),
    definition2 AS (
        SELECT
            name AS endpoint2,
            longname AS `endpoint_definitions.fg-r12.longname.endpoint2`,
            `is_core?` AS `endpoint_definitions.fg-r12.is_core?.endpoint2`
        FROM endpoint_definitions
    ),
    her1 AS
    (
        SELECT
            endpoint AS endpoint1,
            h2 AS `ldsc_heritability.fg-r12.h2.endpoint1`,
            h2_se AS `ldsc_heritability.fg-r12.h2_se.endpoint1`
        FROM ldsc_heritability
    ),
    her2 AS
    (
        SELECT
            endpoint AS endpoint2,
            h2 AS `ldsc_heritability.fg-r12.h2.endpoint2`,
            h2_se AS `ldsc_heritability.fg-r12.h2_se.endpoint2`
        FROM ldsc_heritability
    ),
    cc1 AS
    (
        SELECT
            endpoint AS endpoint1,
            n_cases AS `fg_cases_controls.fg-r12.n_cases.endpoint1`,
            n_controls AS `fg_cases_controls.fg-r12.n_controls.endpoint1`,
            n_excl AS `fg_cases_controls.fg-r12.n_excl.endpoint1`
        FROM cases_controls
    ),
    cc2 AS
    (
        SELECT
            endpoint AS endpoint2,
            n_cases AS `fg_cases_controls.fg-r12.n_cases.endpoint2`,
            n_controls AS `fg_cases_controls.fg-r12.n_controls.endpoint2`,
            n_excl AS `fg_cases_controls.fg-r12.n_excl.endpoint2`
        FROM cases_controls
    ),


    -- Finding genes and variants for colocs
   distinct_variants AS
    (
        SELECT DISTINCT
            (cpra, chromosome, pos) AS dis,
            dis.1 AS dis_cpra,
            dis.2 AS dis_chromosome,
            dis.3 AS dis_pos
        FROM variants
    ),
    variants_x_genes AS
    (
        SELECT *
        FROM distinct_variants
        CROSS JOIN genes
        WHERE (dis_chromosome = chromosome) AND (dis_pos > (start - 50000)) AND (dis_pos < (start + 50000))
    ),
    rename AS
    (
        SELECT
            dis_cpra AS cpra,
            name AS gene_name
        FROM variants_x_genes
    ),
    group_genes AS
    (
        SELECT
            cpra,
            groupUniqArray(gene_name) AS arr,
            arrayStringConcat(arr, ',') AS cat,
            concatWithSeparator('=', cpra, cat) AS cpra_genes
        FROM rename
        GROUP BY cpra
    ),
    comb AS
    (
        SELECT
            endpoint1,
            endpoint2,
            groupUniqArray(cpra_genes) AS arr
        FROM variants
        LEFT JOIN group_genes USING (cpra)
        GROUP BY (endpoint1, endpoint2)
    ),
    filter_non_empty AS
    (
        SELECT
            endpoint1,
            endpoint2,
            arrayFilter(aa -> (aa != ''), arr) AS arr_variants_genes,
            arrayStringConcat(arr_variants_genes, ';') AS variants_genes
        FROM comb
    ),
    out_variants_genes AS
    (
        SELECT
            endpoint1,
            endpoint2,
            variants_genes as `autoreport.fg-r12.variants_genes`
        FROM filter_non_empty
    ),


    -- Joining the 2-endpoint statistics
    mega_join AS
    (
        SELECT *
        FROM out_freg_surv
        FULL OUTER JOIN out_ldsc_summary USING (endpoint1, endpoint2)
    ),
    mega_join AS
    (
        SELECT *
        FROM mega_join
        FULL OUTER JOIN out_pheno_corr USING (endpoint1, endpoint2)
    ),
    mega_join AS
    (
        SELECT *
        FROM mega_join
        FULL OUTER JOIN out_autoreport USING (endpoint1, endpoint2)
    ),
    mega_join AS
    (
        select *
        from mega_join
        full outer join out_variants_genes USING (endpoint1, endpoint2)
    ),

    -- Joining the 1-endpoint stats
    mega_join AS
    (
        SELECT *
        FROM mega_join
        LEFT OUTER JOIN definition1 USING (endpoint1)
    ),
    mega_join AS
    (
        SELECT *
        FROM mega_join
        LEFT OUTER JOIN definition2 USING (endpoint2)
    ),
    mega_join AS
    (
        SELECT *
        FROM mega_join
        LEFT OUTER JOIN her1 USING (endpoint1)
    ),
    mega_join AS
    (
        SELECT *
        FROM mega_join
        LEFT OUTER JOIN her2 USING (endpoint2)
    ),
    mega_join AS
    (
        SELECT *
        FROM mega_join
        LEFT OUTER JOIN cc1 USING (endpoint1)
    ),
    mega_join AS
    (
        SELECT *
        FROM mega_join
        LEFT OUTER JOIN cc2 USING (endpoint2)
    )
SELECT
    -- Here we order the columns
    `endpoint1`,
    `endpoint2`,
    `freg_surv.fr-r11.nindivs_endpoint1_then_endpoint2`,
    `freg_surv.fr-r11.endpoint1_hr`,
    `freg_surv.fr-r11.endpoint1_hr_ci_lower`,
    `freg_surv.fr-r11.endpoint1_hr_ci_upper`,
    `freg_surv.fr-r11.endpoint1_hr_pval`,
    `ldsc_summary.fg-r12.rg`,
    `ldsc_summary.fg-r12.rg_pval`,
    `ldsc_summary.fg-r12.rg_se`,
    `ldsc_summary.fg-r12.converged?`,
    `ldsc_heritability.fg-r12.h2.endpoint1`,
    `ldsc_heritability.fg-r12.h2_se.endpoint1`,
    `ldsc_heritability.fg-r12.h2.endpoint2`,
    `ldsc_heritability.fg-r12.h2_se.endpoint2`,
    `endpoint_definitions.fg-r12.longname.endpoint1`,
    `endpoint_definitions.fg-r12.longname.endpoint2`,
    `endpoint_definitions.fg-r12.is_core?.endpoint1`,
    `endpoint_definitions.fg-r12.is_core?.endpoint2`,
    `pheno_corr.fg-r12.jaccard_index`,
    `pheno_corr.fg-r12.case_overlap_N`,
    `pheno_corr.fg-r12.overlap_coef`,
    `pheno_corr.fg-r12.is_subset?`,
    `autoreport.fg-r12.n_gws_hits.endpoint1`,
    `autoreport.fg-r12.n_gws_hits.endpoint2`,
    `autoreport.fg-r12.overlap_same_doe`,
    `autoreport.fg-r12.overlap_opposite_doe`,
    `autoreport.fg-r12.variants_genes`,
    `fg_cases_controls.fg-r12.n_cases.endpoint1`,
    `fg_cases_controls.fg-r12.n_controls.endpoint1`,
    `fg_cases_controls.fg-r12.n_excl.endpoint1`,
    `fg_cases_controls.fg-r12.n_cases.endpoint2`,
    `fg_cases_controls.fg-r12.n_controls.endpoint2`,
    `fg_cases_controls.fg-r12.n_excl.endpoint2`
FROM mega_join

-- More about compression settings for the output file at:
-- https://clickhouse.com/docs/en/sql-reference/statements/select/into-outfile/
INTO OUTFILE 'mega-big-endpoint-file.csv.zst'
COMPRESSION 'zstd' LEVEL 9
FORMAT CSVWithNames;
