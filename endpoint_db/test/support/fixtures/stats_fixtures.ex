defmodule EndpointDB.StatsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `EndpointDB.Stats` context.
  """

  @doc """
  Generate a unary.
  """
  def unary_fixture(attrs \\ %{}) do
    {:ok, unary} =
      attrs
      |> Enum.into(%{
        h2: 120.5,
        endpoint_short_name: "some endpoint_short_name",
        n_cases: 42,
        n_controls: 42,
        n_excl: 42,
        n_gws_hits: 42,
        h2_se: 120.5
      })
      |> EndpointDB.Stats.create_unary()

    unary
  end

  @doc """
  Generate a pair.
  """
  def pair_fixture(attrs \\ %{}) do
    {:ok, pair} =
      attrs
      |> Enum.into(%{
        endpoint1: "some endpoint1",
        endpoint2: "some endpoint2",
        ldsc_rg: 120.5,
        ldsc_rg_pval: 120.5,
        ldsc_rg_se: 120.5,
        ldsc_converged?: true,
        jaccard_index: 120.5,
        case_overlap_N: 42,
        overlap_coef: 120.5,
        is_subset?: true,
        overlap_same_doe: 120.5,
        overlap_opposite_doe: 120.5,
        variants_genes: "some variants_genes"
      })
      |> EndpointDB.Stats.create_pair()

    pair
  end

  @doc """
  Generate a survival_analysis.
  """
  def survival_analysis_fixture(attrs \\ %{}) do
    {:ok, survival_analysis} =
      attrs
      |> Enum.into(%{
        prior_endpoint: "some prior_endpoint",
        outcome_endpoint: "some outcome_endpoint",
        nindivs_prior_then_outcome: 42,
        endpoint1_hr: 120.5,
        endpoint1_hr_ci_lower: 120.5,
        endpoint1_hr_ci_upper: 120.5,
        endpoint1_hr_pval: 120.5
      })
      |> EndpointDB.Stats.create_survival_analysis()

    survival_analysis
  end
end
