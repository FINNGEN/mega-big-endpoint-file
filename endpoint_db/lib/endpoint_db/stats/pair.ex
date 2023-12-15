defmodule EndpointDB.Stats.Pair do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pair_stats" do
    field :endpoint1, :string
    field :endpoint2, :string
    field :ldsc_rg, :float
    field :ldsc_rg_pval, :float
    field :ldsc_rg_se, :float
    field :ldsc_converged?, :boolean
    field :jaccard_index, :float
    field :case_overlap_N, :integer
    field :overlap_coef, :float
    field :is_subset?, :boolean
    field :overlap_same_doe, :float
    field :overlap_opposite_doe, :float
    field :variants_genes, {:map, {:array, :string}}

    timestamps()
  end

  @doc false
  def changeset(pair, attrs) do
    pair
    |> cast(attrs, [:endpoint1, :endpoint2, :ldsc_rg, :ldsc_rg_pval, :ldsc_rg_se, :ldsc_converged?, :jaccard_index, :case_overlap_N, :overlap_coef, :is_subset?, :overlap_same_doe, :overlap_opposite_doe, :variants_genes])
    |> validate_required([:endpoint1, :endpoint2])
  end
end
