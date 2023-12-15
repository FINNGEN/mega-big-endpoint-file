defmodule EndpointDB.Stats.Unary do
  use Ecto.Schema
  import Ecto.Changeset

  schema "unary_stats" do
    field :endpoint_short_name, :string
    field :endpoint_long_name, :string
    field :n_cases, :integer
    field :n_controls, :integer
    field :n_excl, :integer
    field :n_gws_hits, :integer
    field :h2, :float
    field :h2_se, :float
    field :is_core, :boolean

    timestamps()
  end

  @doc false
  def changeset(unary, attrs) do
    unary
    |> cast(attrs, [:endpoint_short_name, :endpoint_long_name, :n_cases, :n_controls, :n_excl, :n_gws_hits, :h2, :h2_se, :is_core])
    |> validate_required([:endpoint_short_name, :endpoint_long_name, :n_cases, :n_controls, :n_excl])
  end
end
