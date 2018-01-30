defmodule WePager.Repo.Migrations.CreateRecords do
  use Ecto.Migration

  def change do
    create table(:records, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :meta_type, :string
      add :meta_name, :string
      add :meta_order, :integer
      add :meta_active, :boolean, default: false, null: false
      add :body, :map
      add :expiry_date, :naive_datetime
      add :project_name_id, :string
      add :project_id, references(:projects, type: :binary_id, on_delete: :delete_all)

      timestamps()
    end

  end
end
