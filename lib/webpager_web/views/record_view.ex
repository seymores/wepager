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
    %{id: record.id,
      meta_type: record.meta_type,
      meta_name: record.meta_name,
      meta_order: record.meta_order,
      meta_active: record.meta_active,
      body: record.body,
      project_name_id: record.project_name_id}
  end
end
