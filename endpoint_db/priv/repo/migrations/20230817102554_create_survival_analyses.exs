defmodule EndpointDB.Repo.Migrations.CreateSurvivalAnalyses do
  use Ecto.Migration

  def change do
    create table(:survival_analyses) do
      add :prior_endpoint, :string
      add :outcome_endpoint, :string
      add :nindivs_prior_then_outcome, :integer
      add :endpoint1_hr, :float
      add :endpoint1_hr_ci_lower, :float
      add :endpoint1_hr_ci_upper, :float
      add :endpoint1_hr_pval, :float

      timestamps()
    end

    create unique_index(:survival_analyses, [:prior_endpoint, :outcome_endpoint])
  end
end
