defmodule EndpointDB.Stats do
  @moduledoc """
  The Stats context.
  """

  import Ecto.Query, warn: false
  alias EndpointDB.Repo

  alias EndpointDB.Stats.Unary

  require Logger

  @doc """
  Returns the list of unary_stats.

  ## Examples

      iex> list_unary_stats()
      [%Unary{}, ...]

  """
  def list_unary_stats do
    Repo.all(Unary)
  end

  @doc """
  Gets a single unary.

  Raises `Ecto.NoResultsError` if the Unary does not exist.

  ## Examples

      iex> get_unary!(123)
      %Unary{}

      iex> get_unary!(456)
      ** (Ecto.NoResultsError)

  """
  def get_unary!(id), do: Repo.get!(Unary, id)

  @doc """
  Creates a unary.

  ## Examples

      iex> create_unary(%{field: value})
      {:ok, %Unary{}}

      iex> create_unary(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_unary(attrs \\ %{}) do
    %Unary{}
    |> Unary.changeset(attrs)
    |> Repo.insert()
  end

  def upsert_unary(attrs) do
    upsert(attrs, [:endpoint_short_name], %Unary{}, &Unary.changeset/2)
  end

  defp upsert(attrs, keys_if_empty, struct, changeset_fun) do
    keys_left =
      attrs
      |> remove_nil_fields()
      |> Map.keys()
      |> MapSet.new()

    if not MapSet.equal?(keys_left, MapSet.new(keys_if_empty)) do
      struct
      |> changeset_fun.(attrs)
      |> Repo.insert(on_conflict: :replace_all, conflict_target: keys_if_empty)
    else
      {:ok, %{}}
    end
  end

  @doc """
  Updates a unary.

  ## Examples

      iex> update_unary(unary, %{field: new_value})
      {:ok, %Unary{}}

      iex> update_unary(unary, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_unary(%Unary{} = unary, attrs) do
    unary
    |> Unary.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a unary.

  ## Examples

      iex> delete_unary(unary)
      {:ok, %Unary{}}

      iex> delete_unary(unary)
      {:error, %Ecto.Changeset{}}

  """
  def delete_unary(%Unary{} = unary) do
    Repo.delete(unary)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking unary changes.

  ## Examples

      iex> change_unary(unary)
      %Ecto.Changeset{data: %Unary{}}

  """
  def change_unary(%Unary{} = unary, attrs \\ %{}) do
    Unary.changeset(unary, attrs)
  end

  alias EndpointDB.Stats.Pair

  @doc """
  Returns the list of pair_stats.

  ## Examples

      iex> list_pair_stats()
      [%Pair{}, ...]

  """
  def list_pair_stats do
    Repo.all(Pair)
  end

  @doc """
  Gets a single pair.

  Raises `Ecto.NoResultsError` if the Pair does not exist.

  ## Examples

      iex> get_pair!(123)
      %Pair{}

      iex> get_pair!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pair!(id), do: Repo.get!(Pair, id)

  @doc """
  Creates a pair.

  ## Examples

      iex> create_pair(%{field: value})
      {:ok, %Pair{}}

      iex> create_pair(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_pair(attrs \\ %{}) do
    %Pair{}
    |> Pair.changeset(attrs)
    |> Repo.insert()
  end

  def upsert_pair(attrs) do
    upsert(attrs, [:endpoint1, :endpoint2], %Pair{}, &Pair.changeset/2)
  end

  @doc """
  Updates a pair.

  ## Examples

      iex> update_pair(pair, %{field: new_value})
      {:ok, %Pair{}}

      iex> update_pair(pair, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pair(%Pair{} = pair, attrs) do
    pair
    |> Pair.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a pair.

  ## Examples

      iex> delete_pair(pair)
      {:ok, %Pair{}}

      iex> delete_pair(pair)
      {:error, %Ecto.Changeset{}}

  """
  def delete_pair(%Pair{} = pair) do
    Repo.delete(pair)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking pair changes.

  ## Examples

      iex> change_pair(pair)
      %Ecto.Changeset{data: %Pair{}}

  """
  def change_pair(%Pair{} = pair, attrs \\ %{}) do
    Pair.changeset(pair, attrs)
  end

  alias EndpointDB.Stats.SurvivalAnalysis

  @doc """
  Returns the list of survival_analyses.

  ## Examples

      iex> list_survival_analyses()
      [%SurvivalAnalysis{}, ...]

  """
  def list_survival_analyses do
    Repo.all(SurvivalAnalysis)
  end

  @doc """
  Gets a single survival_analysis.

  Raises `Ecto.NoResultsError` if the Survival analysis does not exist.

  ## Examples

      iex> get_survival_analysis!(123)
      %SurvivalAnalysis{}

      iex> get_survival_analysis!(456)
      ** (Ecto.NoResultsError)

  """
  def get_survival_analysis!(id), do: Repo.get!(SurvivalAnalysis, id)

  @doc """
  Creates a survival_analysis.

  ## Examples

      iex> create_survival_analysis(%{field: value})
      {:ok, %SurvivalAnalysis{}}

      iex> create_survival_analysis(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_survival_analysis(attrs \\ %{}) do
    %SurvivalAnalysis{}
    |> SurvivalAnalysis.changeset(attrs)
    |> Repo.insert()
  end

  def upsert_survival_analysis(attrs) do
    upsert(
      attrs,
      [:prior_endpoint, :outcome_endpoint],
      %SurvivalAnalysis{},
      &SurvivalAnalysis.changeset/2
    )
  end

  @doc """
  Updates a survival_analysis.

  ## Examples

      iex> update_survival_analysis(survival_analysis, %{field: new_value})
      {:ok, %SurvivalAnalysis{}}

      iex> update_survival_analysis(survival_analysis, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_survival_analysis(%SurvivalAnalysis{} = survival_analysis, attrs) do
    survival_analysis
    |> SurvivalAnalysis.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a survival_analysis.

  ## Examples

      iex> delete_survival_analysis(survival_analysis)
      {:ok, %SurvivalAnalysis{}}

      iex> delete_survival_analysis(survival_analysis)
      {:error, %Ecto.Changeset{}}

  """
  def delete_survival_analysis(%SurvivalAnalysis{} = survival_analysis) do
    Repo.delete(survival_analysis)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking survival_analysis changes.

  ## Examples

      iex> change_survival_analysis(survival_analysis)
      %Ecto.Changeset{data: %SurvivalAnalysis{}}

  """
  def change_survival_analysis(%SurvivalAnalysis{} = survival_analysis, attrs \\ %{}) do
    SurvivalAnalysis.changeset(survival_analysis, attrs)
  end

  def insert_all_from_file(file_path) do
    file_path
    |> parse_stats_from_file()
    |> Enum.each(fn rec ->
      # Unary stats
      endpoint1_unary_stats = %{
        endpoint_short_name: rec.endpoint1,
        n_cases: rec.n_cases_endpoint1,
        n_controls: rec.n_controls_endpoint1,
        n_excl: rec.n_excl_endpoint1,
        n_gws_hits: rec.n_gws_hits_endpoint1,
        h2: rec.h2_endpoint1,
        h2_se: rec.h2_se_endpoint1,
        is_core: rec.is_core_endpoint1
      }

      endpoint2_unary_stats = %{
        endpoint_short_name: rec.endpoint2,
        n_cases: rec.n_cases_endpoint2,
        n_controls: rec.n_controls_endpoint2,
        n_excl: rec.n_excl_endpoint2,
        n_gws_hits: rec.n_gws_hits_endpoint2,
        h2: rec.h2_endpoint2,
        h2_se: rec.h2_se_endpoint2,
        is_core: rec.is_core_endpoint2
      }

      # TODO somehow 1 endpoint has "NA" for N cases, controls and excl. Need to fix in input data.
      [endpoint1_unary_stats, endpoint2_unary_stats]
      |> Enum.reject(fn ustats ->
        is_nil(ustats.n_cases) or is_nil(ustats.n_controls) or is_nil(ustats.n_excl)
      end)
      |> Enum.each(fn ustats ->
        {:ok, _} = upsert_unary(ustats)
      end)

      # Pair stats
      [col1, col2] = Enum.sort([rec.endpoint1, rec.endpoint2])

      pair_stats = %{
        endpoint1: col1,
        endpoint2: col2,
        ldsc_rg: rec.ldsc_rg,
        ldsc_rg_pval: rec.ldsc_rg_pval,
        ldsc_rg_se: rec.ldsc_rg_se,
        ldsc_converged?: rec.ldsc_converged?,
        jaccard_index: rec.jaccard_index,
        case_overlap_N: rec.case_overlap_N,
        overlap_coef: rec.overlap_coef,
        is_subset?: rec.is_subset?,
        overlap_same_doe: rec.overlap_same_doe,
        overlap_opposite_doe: rec.overlap_opposite_doe,
        variants_genes: rec.variants_genes
      }

      {:ok, _} = upsert_pair(pair_stats)

      # Survival Analysis
      surv_stats = %{
        prior_endpoint: rec.endpoint1,
        outcome_endpoint: rec.endpoint2,
        nindivs_prior_then_outcome: rec.nindivs_prior_then_outcome,
        endpoint1_hr: rec.endpoint1_hr,
        endpoint1_hr_ci_lower: rec.endpoint1_hr_ci_lower,
        endpoint1_hr_ci_upper: rec.endpoint1_hr_ci_upper,
        endpoint1_hr_pval: rec.endpoint1_hr_pval
      }

      {:ok, _} = upsert_survival_analysis(surv_stats)
    end)
  end

  defp parse_stats_from_file(file_path) do
    file_path
    |> File.stream!()
    |> CSV.decode!(headers: true)
    |> Stream.map(&parse_row/1)
  end

  defp parse_row(row) do
    %{
      "endpoint1" => endpoint1,
      "endpoint2" => endpoint2
    } = row

    %{
      "freg_surv.fr-r11.nindivs_endpoint1_then_endpoint2" => nindivs_prior_then_outcome,
      "freg_surv.fr-r11.endpoint1_hr" => endpoint1_hr,
      "freg_surv.fr-r11.endpoint1_hr_ci_lower" => endpoint1_hr_ci_lower,
      "freg_surv.fr-r11.endpoint1_hr_ci_upper" => endpoint1_hr_ci_upper,
      "freg_surv.fr-r11.endpoint1_hr_pval" => endpoint1_hr_pval
    } = row

    %{
      "ldsc_summary.fg-r12.rg" => ldsc_rg,
      "ldsc_summary.fg-r12.rg_pval" => ldsc_rg_pval,
      "ldsc_summary.fg-r12.rg_se" => ldsc_rg_se,
      "ldsc_summary.fg-r12.converged?" => ldsc_converged?,
      "pheno_corr.fg-r12.jaccard_index" => jaccard_index,
      "pheno_corr.fg-r12.case_overlap_N" => case_overlap_N,
      "pheno_corr.fg-r12.overlap_coef" => overlap_coef,
      "pheno_corr.fg-r12.is_subset?" => is_subset?,
      "autoreport.fg-r12.overlap_same_doe" => overlap_same_doe,
      "autoreport.fg-r12.overlap_opposite_doe" => overlap_opposite_doe,
      "autoreport.fg-r12.variants_genes" => variants_genes
    } = row

    %{
      "ldsc_heritability.fg-r12.h2.endpoint1" => h2_endpoint1,
      "ldsc_heritability.fg-r12.h2_se.endpoint1" => h2_se_endpoint1,
      "ldsc_heritability.fg-r12.h2.endpoint2" => h2_endpoint2,
      "ldsc_heritability.fg-r12.h2_se.endpoint2" => h2_se_endpoint2,
      "autoreport.fg-r12.n_gws_hits.endpoint1" => n_gws_hits_endpoint1,
      "autoreport.fg-r12.n_gws_hits.endpoint2" => n_gws_hits_endpoint2,
      "fg_cases_controls.fg-r12.n_cases.endpoint1" => n_cases_endpoint1,
      "fg_cases_controls.fg-r12.n_controls.endpoint1" => n_controls_endpoint1,
      "fg_cases_controls.fg-r12.n_excl.endpoint1" => n_excl_endpoint1,
      "fg_cases_controls.fg-r12.n_cases.endpoint2" => n_cases_endpoint2,
      "fg_cases_controls.fg-r12.n_controls.endpoint2" => n_controls_endpoint2,
      "fg_cases_controls.fg-r12.n_excl.endpoint2" => n_excl_endpoint2,
      "endpoint_definition.fg-r12.is_core?.endpoint1" => is_core_endpoint1,
      "endpoint_definition.fg-r12.is_core?.endpoint2" => is_core_endpoint2
    } = row

    %{
      endpoint1: endpoint1,
      endpoint2: endpoint2,
      nindivs_prior_then_outcome: parse_maybe_integer(nindivs_prior_then_outcome),
      endpoint1_hr: parse_maybe_float(endpoint1_hr),
      endpoint1_hr_ci_lower: parse_maybe_float(endpoint1_hr_ci_lower),
      endpoint1_hr_ci_upper: parse_maybe_float(endpoint1_hr_ci_upper),
      endpoint1_hr_pval: parse_maybe_float(endpoint1_hr_pval),
      ldsc_rg: parse_maybe_float(ldsc_rg),
      ldsc_rg_pval: parse_maybe_float(ldsc_rg_pval),
      ldsc_rg_se: parse_maybe_float(ldsc_rg_se),
      ldsc_converged?: parse_maybe_boolean(ldsc_converged?),
      jaccard_index: parse_maybe_float(jaccard_index),
      case_overlap_N: parse_maybe_integer(case_overlap_N),
      overlap_coef: parse_maybe_float(overlap_coef),
      is_subset?: parse_maybe_boolean(is_subset?),
      overlap_same_doe: parse_maybe_float(overlap_same_doe),
      overlap_opposite_doe: parse_maybe_float(overlap_opposite_doe),
      variants_genes: parse_maybe_map_variants_genes(variants_genes),
      h2_endpoint1: parse_maybe_float(h2_endpoint1),
      h2_se_endpoint1: parse_maybe_float(h2_se_endpoint1),
      h2_endpoint2: parse_maybe_float(h2_endpoint2),
      h2_se_endpoint2: parse_maybe_float(h2_se_endpoint2),
      n_gws_hits_endpoint1: parse_maybe_integer(n_gws_hits_endpoint1),
      n_gws_hits_endpoint2: parse_maybe_integer(n_gws_hits_endpoint2),
      n_cases_endpoint1: parse_maybe_integer(n_cases_endpoint1),
      n_controls_endpoint1: parse_maybe_integer(n_controls_endpoint1),
      n_excl_endpoint1: parse_maybe_integer(n_excl_endpoint1),
      n_cases_endpoint2: parse_maybe_integer(n_cases_endpoint2),
      n_controls_endpoint2: parse_maybe_integer(n_controls_endpoint2),
      n_excl_endpoint2: parse_maybe_integer(n_excl_endpoint2),
      is_core_endpoint1: parse_boolean(is_core_endpoint1),
      is_core_endpoint2: parse_boolean(is_core_endpoint2)
    }
  end

  defp parse_maybe_float(value) do
    case Float.parse(value) do
      {parsed, _remainder} ->
        parsed

      :error ->
        nil
    end
  end

  defp parse_maybe_integer(value) do
    case Integer.parse(value) do
      {parsed, _remainder} ->
        parsed

      :error ->
        nil
    end
  end

  defp parse_boolean(value) do
    case value do
      "true" ->
        true

      "false" ->
        false

      "␀" ->
        nil
    end
  end

  defp parse_maybe_boolean(value) do
    case value do
      "true" ->
        true

      "false" ->
        false

      "␀" ->
        nil
    end
  end

  defp parse_maybe_map_variants_genes(value) do
    case value do
      "␀" ->
        nil

      "" ->
        nil

      _ ->
        for rec <- String.split(value, ";"), into: %{} do
          [variant, genes_str] = String.split(rec, "=", parts: 2)
          genes = String.split(genes_str, ",")
          {variant, genes}
        end
    end
  end

  defp remove_nil_fields(map) do
    for {key, value} <- map, not is_nil(value), into: %{} do
      {key, value}
    end
  end
end
