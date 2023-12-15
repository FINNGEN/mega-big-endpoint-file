defmodule EndpointDB.Repo.Migrations.AlterUnaryStatsAddLongName do
  use Ecto.Migration

  def change do
    alter table(:unary_stats) do
      add :endpoint_long_name, :string, null: false
    end
  end
end
