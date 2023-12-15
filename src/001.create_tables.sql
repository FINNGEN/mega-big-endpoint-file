CREATE TABLE config
(
    `name` String,
    `path` String
)
ENGINE = MergeTree
PRIMARY KEY name;

CREATE TABLE endpoint_definitions
(
    `name` String,
    `longname` String,
    `is_core?` Bool
)
ENGINE = MergeTree
PRIMARY KEY name;

CREATE TABLE freg_surv
(
    `prior` String,
    `outcome` String,
    `nindivs_prior_outcome` String,
    `prior_hr` String,
    `prior_ci_lower` String,
    `prior_ci_upper` String,
    `prior_pval` String
)
ENGINE = MergeTree
PRIMARY KEY (prior, outcome);

CREATE TABLE ldsc_summary
(
    `endpoint1` String,
    `endpoint2` String,
    `rg` String,
    `rg_pval` String,
    `rg_se` String,
    `converged?` String
)
ENGINE = MergeTree
PRIMARY KEY (endpoint1, endpoint2);

CREATE TABLE ldsc_heritability
(
    `endpoint` String,
    `h2` String,
    `h2_se` String
)
ENGINE = MergeTree
PRIMARY KEY endpoint;

CREATE TABLE pheno_corr
(
    `endpoint1` String,
    `endpoint2` String,
    `jaccard_index` String,
    `case_overlap_N` String,
    `overlap_coef` String,
    `is_subset?` String
)
ENGINE = MergeTree
PRIMARY KEY (endpoint1, endpoint2);


create table autoreport
(
	endpoint1 String,
	endpoint2 String,
	`n_gws_hits.endpoint1` String,
	`n_gws_hits.endpoint2` String,
	overlap_same_doe String,
	overlap_opposite_doe String,
)
Engine = MergeTree
PRIMARY KEY (endpoint1, endpoint2);

CREATE TABLE cases_controls
(
    `endpoint` String,
    `n_cases` String,
    `n_controls` String,
    `n_excl` String
)
ENGINE = MergeTree
PRIMARY KEY endpoint;

CREATE TABLE variants
(
	`endpoint1` String,
	`endpoint2` String,
    `cpra` String,
    `chromosome` String,
    `pos` UInt32,
    `same_doe?` String
)
ENGINE = MergeTree
PRIMARY KEY (endpoint1, endpoint2);

CREATE TABLE genes
(
	`chromosome` String,
	`name` String,
	`start` UInt64,
	`stop` UInt64
)
ENGINE = MergeTree
PRIMARY KEY (chromosome, start, stop);
