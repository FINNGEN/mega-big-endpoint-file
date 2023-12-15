defmodule EndpointDB.Repo.Migrations.CreatePairStats do
  use Ecto.Migration

  def change do
    create table(:pair_stats) do
      add :endpoint1, :string
      add :endpoint2, :string
      add :ldsc_rg, :float, null: true
      add :ldsc_rg_pval, :float, null: true
      add :ldsc_rg_se, :float, null: true
      add :ldsc_converged?, :boolean, default: nil, null: true
      add :jaccard_index, :float, null: true
      add :case_overlap_N, :integer, null: true
      add :overlap_coef, :float, null: true
      add :is_subset?, :boolean, default: nil, null: true
      add :overlap_same_doe, :float, null: true
      add :overlap_opposite_doe, :float, null: true
      add :variants_genes, {:map, {:array, :string}}, null: true

      timestamps()
    end

    create unique_index(:pair_stats, [:endpoint1, :endpoint2])
  end
end
