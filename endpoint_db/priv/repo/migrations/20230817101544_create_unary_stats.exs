defmodule EndpointDB.Repo.Migrations.CreateUnaryStats do
  use Ecto.Migration

  def change do
    create table(:unary_stats) do
      add :endpoint_short_name, :string
      add :n_cases, :integer
      add :n_controls, :integer
      add :n_excl, :integer
      add :n_gws_hits, :integer, null: true
      add :h2, :float, null: true
      add :h2_se, :float, null: true

      timestamps()
    end

    create unique_index(:unary_stats, [:endpoint_short_name])
  end
end
