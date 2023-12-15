INSERT INTO config FROM INFILE 'config.json' FORMAT JSONEachRow;

INSERT INTO endpoint_definitions SELECT
    NAME as name,
    LONGNAME as longname,
    multiIf(CORE_ENDPOINTS = 'yes', 'true', 'false') as `is_core?`
    FROM file((
        SELECT path
        FROM config
        WHERE name = 'finngen-endpoint-definitions'
    ), CSVWithNames)
;

INSERT INTO freg_surv SELECT
    prior,
    outcome,
    nindivs_prior_outcome,
    prior_hr,
    prior_ci_lower,
    prior_ci_upper,
    prior_pval
FROM file((
    SELECT path
    FROM config
    WHERE name = 'finregistry-survival-analyses'
), 'CSVWithNames');

INSERT INTO ldsc_summary SELECT
    p1 AS endpoint1,
    p2 AS endpoint2,
    rg,
    p AS rg_pval,
    se AS rg_se,
    CONVERGED AS `converged?`
FROM file((
    SELECT path
    FROM config
    WHERE name = 'finngen-ldsc-summary'
), TSVWithNames);

INSERT INTO ldsc_heritability SELECT
    PHENO AS endpoint,
    H2 AS h2,
    SE AS h2_se
FROM file((
    SELECT path
    FROM config
    WHERE name = 'finngen-ldsc-heritability'
), TSVWithNames);

INSERT INTO pheno_corr SELECT
    endpoint_a AS endpoint1,
    endpoint_b AS endpoint2,
    jaccard_index,
    case_overlap_N,
    overlap_coef,
    multiIf(ratio_shared_of_a = '1.0', 'true', 'false') AS `is_subset?`
FROM file((
    SELECT path
    FROM config
    WHERE name = 'finngen-pheno-corr'
), CSVWithNames, 'auto', 'zstd');

INSERT INTO autoreport SELECT
    pheno1 AS endpoint1,
    pheno2 AS endpoint2,
    n_gwsig_1 AS `n_gws_hits.endpoint1`,
    n_gwsig_2 AS `n_gws_hits.endpoint2`,
    overlap_same_doe,
    overlap_diff_doe AS overlap_opposite_doe
FROM file((
    SELECT path
    FROM config
    WHERE name = 'finngen-autoreport'
), TSVWithNames);

INSERT INTO cases_controls SELECT *
FROM file((
    SELECT path
    FROM config
    WHERE name = 'finngen-cases-controls'
), JSONEachRow);

INSERT INTO variants SELECT
    endpoint1,
    endpoint2,
    cpra,
    chromosome,
    pos,
    `same_doe?`
FROM
(
    SELECT
        pheno1 AS endpoint1,
        pheno2 AS endpoint2,
        assumeNotNull(variant) AS cpra,
        splitByChar('_', cpra) AS cpra_split,
        cpra_split[1] AS pre_chromosome,
        cpra_split[2] AS pre_pos,
        substring(pre_chromosome, 4) AS chromosome,
        CAST(pre_pos, 'UInt64') AS pos,
        sign(CAST(beta1, 'Float64')) AS sign_beta1,
        sign(CAST(beta2, 'Float64')) AS sign_beta2,
        multiIf(sign_beta1 = sign_beta2, 'true', 'false') AS `same_doe?`
    FROM file((
        SELECT path
        FROM config
        WHERE name = 'finngen-variants'
    ), TSVWithNames)
);

INSERT INTO genes SELECT
	substr(chromosome, 4) as chromosome,
	gene_name as name,
	start,
	stop
FROM file((
    SELECT path
    FROM config
    WHERE name = 'havana-genes'
), JSONEachRow);
