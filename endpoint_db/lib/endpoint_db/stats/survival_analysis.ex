defmodule EndpointDB.Stats.SurvivalAnalysis do
  use Ecto.Schema
  import Ecto.Changeset

  schema "survival_analyses" do
    field :prior_endpoint, :string
    field :outcome_endpoint, :string
    field :nindivs_prior_then_outcome, :integer
    field :endpoint1_hr, :float
    field :endpoint1_hr_ci_lower, :float
    field :endpoint1_hr_ci_upper, :float
    field :endpoint1_hr_pval, :float

    timestamps()
  end

  @doc false
  def changeset(survival_analysis, attrs) do
    survival_analysis
    |> cast(attrs, [:prior_endpoint, :outcome_endpoint, :nindivs_prior_then_outcome, :endpoint1_hr, :endpoint1_hr_ci_lower, :endpoint1_hr_ci_upper, :endpoint1_hr_pval])
    |> validate_required([:prior_endpoint, :outcome_endpoint, :nindivs_prior_then_outcome, :endpoint1_hr, :endpoint1_hr_ci_lower, :endpoint1_hr_ci_upper, :endpoint1_hr_pval])
  end
end
