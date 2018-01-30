defmodule WePagerWeb.PublicController do
  use WePagerWeb, :controller

  alias WePager.Data
  alias WePager.Data.Record

  action_fallback WePagerWeb.FallbackController

  def index(conn, %{"meta_type" => meta_type, "project_name_id" => project_name_id} = params) do

    start = String.to_integer(params["page"] || "0")
    size = String.to_integer(params["size"] || "50")

    records = Data.list_records(start, size)
    json(conn, records)
    # render(conn, "index.json", records: records)
  end

  def create(conn, %{"body" => body, "meta_type" => meta_type, "project_name_id" => project_name_id} = params) do
    with {:ok, %Record{} = record} <- Data.create_record(params) do
      conn
      |> put_status(:created)
      |> json(record)
    end
  end

  def show(conn, %{"id" => id}) do
    record = Data.get_record!(id)
    json(conn, record)
  end

  def update(conn, %{"id" => id, "body" => body, "meta_type" => meta_type, "project_name_id" => project_name_id} = params) do
    record = Data.get_record!(id)

    with {:ok, %Record{} = record} <- Data.update_record(record, params) do
      json(conn, record)
    end
  end

  def delete(conn, %{"id" => id}) do
    record = Data.get_record!(id)
    with {:ok, %Record{}} <- Data.delete_record(record) do
      send_resp(conn, :no_content, "")
    end
  end
end
