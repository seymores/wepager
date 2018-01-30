defmodule WePager.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  def change do
    create table(:projects, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :expiry_date, :naive_datetime
      add :meta, :map
      add :name, :string
      add :project_name_id, :string

      timestamps()
    end

    create unique_index(:projects, [:project_name_id])
  end
end
