defmodule WePagerWeb.RecordView do
  use WePagerWeb, :view
  alias WePagerWeb.RecordView

  def render("index.json", %{records: records}) do
    %{data: render_many(records, RecordView, "record.json")}
  end

  def render("show.json", %{record: record}) do
    %{data: render_one(record, RecordView, "record.json")}
  end

  def render("record.json", %{record: record}) do
    %{
      id: record.id,
      meta: %{
        type: record.meta_type || "",
        name: record.meta_name || "",
        order: record.meta_order || 0,
        active: record.meta_active || true
      },
      project_name_id: record.project_name_id,
      body: record.body || %{}
    } |> Map.merge(record.body)
  end
end
