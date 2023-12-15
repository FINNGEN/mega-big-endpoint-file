defmodule EndpointDB.StatsTest do
  use EndpointDB.DataCase

  alias EndpointDB.Stats

  describe "unary_stats" do
    alias EndpointDB.Stats.Unary

    import EndpointDB.StatsFixtures

    @invalid_attrs %{h2: nil, endpoint_short_name: nil, n_cases: nil, n_controls: nil, n_excl: nil, n_gws_hits: nil, h2_se: nil}

    test "list_unary_stats/0 returns all unary_stats" do
      unary = unary_fixture()
      assert Stats.list_unary_stats() == [unary]
    end

    test "get_unary!/1 returns the unary with given id" do
      unary = unary_fixture()
      assert Stats.get_unary!(unary.id) == unary
    end

    test "create_unary/1 with valid data creates a unary" do
      valid_attrs = %{h2: 120.5, endpoint_short_name: "some endpoint_short_name", n_cases: 42, n_controls: 42, n_excl: 42, n_gws_hits: 42, h2_se: 120.5}

      assert {:ok, %Unary{} = unary} = Stats.create_unary(valid_attrs)
      assert unary.h2 == 120.5
      assert unary.endpoint_short_name == "some endpoint_short_name"
      assert unary.n_cases == 42
      assert unary.n_controls == 42
      assert unary.n_excl == 42
      assert unary.n_gws_hits == 42
      assert unary.h2_se == 120.5
    end

    test "create_unary/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stats.create_unary(@invalid_attrs)
    end

    test "update_unary/2 with valid data updates the unary" do
      unary = unary_fixture()
      update_attrs = %{h2: 456.7, endpoint_short_name: "some updated endpoint_short_name", n_cases: 43, n_controls: 43, n_excl: 43, n_gws_hits: 43, h2_se: 456.7}

      assert {:ok, %Unary{} = unary} = Stats.update_unary(unary, update_attrs)
      assert unary.h2 == 456.7
      assert unary.endpoint_short_name == "some updated endpoint_short_name"
      assert unary.n_cases == 43
      assert unary.n_controls == 43
      assert unary.n_excl == 43
      assert unary.n_gws_hits == 43
      assert unary.h2_se == 456.7
    end

    test "update_unary/2 with invalid data returns error changeset" do
      unary = unary_fixture()
      assert {:error, %Ecto.Changeset{}} = Stats.update_unary(unary, @invalid_attrs)
      assert unary == Stats.get_unary!(unary.id)
    end

    test "delete_unary/1 deletes the unary" do
      unary = unary_fixture()
      assert {:ok, %Unary{}} = Stats.delete_unary(unary)
      assert_raise Ecto.NoResultsError, fn -> Stats.get_unary!(unary.id) end
    end

    test "change_unary/1 returns a unary changeset" do
      unary = unary_fixture()
      assert %Ecto.Changeset{} = Stats.change_unary(unary)
    end
  end

  describe "pair_stats" do
    alias EndpointDB.Stats.Pair

    import EndpointDB.StatsFixtures

    @invalid_attrs %{endpoint1: nil, endpoint2: nil, ldsc_rg: nil, ldsc_rg_pval: nil, ldsc_rg_se: nil, ldsc_converged?: nil, jaccard_index: nil, case_overlap_N: nil, overlap_coef: nil, is_subset?: nil, overlap_same_doe: nil, overlap_opposite_doe: nil, variants_genes: nil}

    test "list_pair_stats/0 returns all pair_stats" do
      pair = pair_fixture()
      assert Stats.list_pair_stats() == [pair]
    end

    test "get_pair!/1 returns the pair with given id" do
      pair = pair_fixture()
      assert Stats.get_pair!(pair.id) == pair
    end

    test "create_pair/1 with valid data creates a pair" do
      valid_attrs = %{endpoint1: "some endpoint1", endpoint2: "some endpoint2", ldsc_rg: 120.5, ldsc_rg_pval: 120.5, ldsc_rg_se: 120.5, ldsc_converged?: true, jaccard_index: 120.5, case_overlap_N: 42, overlap_coef: 120.5, is_subset?: true, overlap_same_doe: 120.5, overlap_opposite_doe: 120.5, variants_genes: "some variants_genes"}

      assert {:ok, %Pair{} = pair} = Stats.create_pair(valid_attrs)
      assert pair.endpoint1 == "some endpoint1"
      assert pair.endpoint2 == "some endpoint2"
      assert pair.ldsc_rg == 120.5
      assert pair.ldsc_rg_pval == 120.5
      assert pair.ldsc_rg_se == 120.5
      assert pair.ldsc_converged? == true
      assert pair.jaccard_index == 120.5
      assert pair.case_overlap_N == 42
      assert pair.overlap_coef == 120.5
      assert pair.is_subset? == true
      assert pair.overlap_same_doe == 120.5
      assert pair.overlap_opposite_doe == 120.5
      assert pair.variants_genes == "some variants_genes"
    end

    test "create_pair/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stats.create_pair(@invalid_attrs)
    end

    test "update_pair/2 with valid data updates the pair" do
      pair = pair_fixture()
      update_attrs = %{endpoint1: "some updated endpoint1", endpoint2: "some updated endpoint2", ldsc_rg: 456.7, ldsc_rg_pval: 456.7, ldsc_rg_se: 456.7, ldsc_converged?: false, jaccard_index: 456.7, case_overlap_N: 43, overlap_coef: 456.7, is_subset?: false, overlap_same_doe: 456.7, overlap_opposite_doe: 456.7, variants_genes: "some updated variants_genes"}

      assert {:ok, %Pair{} = pair} = Stats.update_pair(pair, update_attrs)
      assert pair.endpoint1 == "some updated endpoint1"
      assert pair.endpoint2 == "some updated endpoint2"
      assert pair.ldsc_rg == 456.7
      assert pair.ldsc_rg_pval == 456.7
      assert pair.ldsc_rg_se == 456.7
      assert pair.ldsc_converged? == false
      assert pair.jaccard_index == 456.7
      assert pair.case_overlap_N == 43
      assert pair.overlap_coef == 456.7
      assert pair.is_subset? == false
      assert pair.overlap_same_doe == 456.7
      assert pair.overlap_opposite_doe == 456.7
      assert pair.variants_genes == "some updated variants_genes"
    end

    test "update_pair/2 with invalid data returns error changeset" do
      pair = pair_fixture()
      assert {:error, %Ecto.Changeset{}} = Stats.update_pair(pair, @invalid_attrs)
      assert pair == Stats.get_pair!(pair.id)
    end

    test "delete_pair/1 deletes the pair" do
      pair = pair_fixture()
      assert {:ok, %Pair{}} = Stats.delete_pair(pair)
      assert_raise Ecto.NoResultsError, fn -> Stats.get_pair!(pair.id) end
    end

    test "change_pair/1 returns a pair changeset" do
      pair = pair_fixture()
      assert %Ecto.Changeset{} = Stats.change_pair(pair)
    end
  end

  describe "survival_analyses" do
    alias EndpointDB.Stats.SurvivalAnalysis

    import EndpointDB.StatsFixtures

    @invalid_attrs %{prior_endpoint: nil, outcome_endpoint: nil, nindivs_prior_then_outcome: nil, endpoint1_hr: nil, endpoint1_hr_ci_lower: nil, endpoint1_hr_ci_upper: nil, endpoint1_hr_pval: nil}

    test "list_survival_analyses/0 returns all survival_analyses" do
      survival_analysis = survival_analysis_fixture()
      assert Stats.list_survival_analyses() == [survival_analysis]
    end

    test "get_survival_analysis!/1 returns the survival_analysis with given id" do
      survival_analysis = survival_analysis_fixture()
      assert Stats.get_survival_analysis!(survival_analysis.id) == survival_analysis
    end

    test "create_survival_analysis/1 with valid data creates a survival_analysis" do
      valid_attrs = %{prior_endpoint: "some prior_endpoint", outcome_endpoint: "some outcome_endpoint", nindivs_prior_then_outcome: 42, endpoint1_hr: 120.5, endpoint1_hr_ci_lower: 120.5, endpoint1_hr_ci_upper: 120.5, endpoint1_hr_pval: 120.5}

      assert {:ok, %SurvivalAnalysis{} = survival_analysis} = Stats.create_survival_analysis(valid_attrs)
      assert survival_analysis.prior_endpoint == "some prior_endpoint"
      assert survival_analysis.outcome_endpoint == "some outcome_endpoint"
      assert survival_analysis.nindivs_prior_then_outcome == 42
      assert survival_analysis.endpoint1_hr == 120.5
      assert survival_analysis.endpoint1_hr_ci_lower == 120.5
      assert survival_analysis.endpoint1_hr_ci_upper == 120.5
      assert survival_analysis.endpoint1_hr_pval == 120.5
    end

    test "create_survival_analysis/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stats.create_survival_analysis(@invalid_attrs)
    end

    test "update_survival_analysis/2 with valid data updates the survival_analysis" do
      survival_analysis = survival_analysis_fixture()
      update_attrs = %{prior_endpoint: "some updated prior_endpoint", outcome_endpoint: "some updated outcome_endpoint", nindivs_prior_then_outcome: 43, endpoint1_hr: 456.7, endpoint1_hr_ci_lower: 456.7, endpoint1_hr_ci_upper: 456.7, endpoint1_hr_pval: 456.7}

      assert {:ok, %SurvivalAnalysis{} = survival_analysis} = Stats.update_survival_analysis(survival_analysis, update_attrs)
      assert survival_analysis.prior_endpoint == "some updated prior_endpoint"
      assert survival_analysis.outcome_endpoint == "some updated outcome_endpoint"
      assert survival_analysis.nindivs_prior_then_outcome == 43
      assert survival_analysis.endpoint1_hr == 456.7
      assert survival_analysis.endpoint1_hr_ci_lower == 456.7
      assert survival_analysis.endpoint1_hr_ci_upper == 456.7
      assert survival_analysis.endpoint1_hr_pval == 456.7
    end

    test "update_survival_analysis/2 with invalid data returns error changeset" do
      survival_analysis = survival_analysis_fixture()
      assert {:error, %Ecto.Changeset{}} = Stats.update_survival_analysis(survival_analysis, @invalid_attrs)
      assert survival_analysis == Stats.get_survival_analysis!(survival_analysis.id)
    end

    test "delete_survival_analysis/1 deletes the survival_analysis" do
      survival_analysis = survival_analysis_fixture()
      assert {:ok, %SurvivalAnalysis{}} = Stats.delete_survival_analysis(survival_analysis)
      assert_raise Ecto.NoResultsError, fn -> Stats.get_survival_analysis!(survival_analysis.id) end
    end

    test "change_survival_analysis/1 returns a survival_analysis changeset" do
      survival_analysis = survival_analysis_fixture()
      assert %Ecto.Changeset{} = Stats.change_survival_analysis(survival_analysis)
    end
  end
end
