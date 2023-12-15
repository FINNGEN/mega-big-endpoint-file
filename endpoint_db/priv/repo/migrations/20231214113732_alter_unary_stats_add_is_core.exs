defmodule EndpointDB.Repo.Migrations.AlterUnaryStatsAddIsCore do
  use Ecto.Migration

  def change do
    alter table(:unary_stats) do
      add :is_core, :boolean, null: false
    end
  end
end
