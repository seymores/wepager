defmodule WePager.Data.Project do
  use Ecto.Schema
  import Ecto.Changeset
  alias WePager.Data.Project


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "projects" do
    field :expiry_date, :naive_datetime
    field :meta, :map
    field :name, :string
    field :project_name_id, :string

    timestamps()
  end

  @doc false
  def changeset(%Project{} = project, attrs) do
    project
    |> cast(attrs, [:expiry_date, :meta, :name, :project_name_id])
    |> validate_required([:project_name_id])
    |> unique_constraint(:project_name_id)
  end
end
