defmodule WePager.Data.Record do
  use Ecto.Schema
  import Ecto.Changeset
  alias WePager.Data.{Record, Project}


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "records" do
    field :project_name_id, :string
    field :body, :map
    field :meta_active, :boolean, default: false
    field :meta_name, :string
    field :meta_order, :integer
    field :meta_type, :string
    field :expiry_date, :naive_datetime

    belongs_to :project, Project, foreign_key: :project_id

    timestamps()
  end

  @doc false
  def changeset(%Record{} = record, attrs) do
    record
    |> cast(attrs, [:meta_type, :meta_name, :meta_order, :meta_active, :body, :project_id, :project_name_id, :expiry_date])
    |> validate_required([:body, :project_id, :project_name_id])
  end
end
