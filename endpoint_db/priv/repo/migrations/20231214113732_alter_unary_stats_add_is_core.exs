defmodule EndpointDB.Repo.Migrations.AlterUnaryStatsAddIsCore do
  use Ecto.Migration

  def change do
    alter table(:unary_stats) do
      # We allow null values since some endpoints (like 'HEIGHT_IRN') are made
      # outside of the endpoint definitions file, which is the only source
      # of 'is_core' information.
      add :is_core, :boolean, null: true
    end
  end
end
