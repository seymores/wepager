defmodule WePagerWeb.RecordController do
  use WePagerWeb, :controller

  alias WePager.Data
  alias WePager.Data.Record

  action_fallback WePagerWeb.FallbackController

  def index(conn, params) do
    start = String.to_integer(params["page"] || "0")
    size = String.to_integer(params["size"] || "50")

    records = Data.list_records(start, size)
    render(conn, "index.json", records: records)
  end

  def create(conn, %{"record" => record_params}) do
    with {:ok, %Record{} = record} <- Data.create_record(record_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", record_path(conn, :show, record))
      |> render("show.json", record: record)
    end
  end

  def show(conn, %{"id" => id}) do
    record = Data.get_record!(id)
    render(conn, "show.json", record: record)
  end

  def update(conn, %{"id" => id, "record" => record_params}) do
    record = Data.get_record!(id)

    with {:ok, %Record{} = record} <- Data.update_record(record, record_params) do
      render(conn, "show.json", record: record)
    end
  end

  def delete(conn, %{"id" => id}) do
    record = Data.get_record!(id)
    with {:ok, %Record{}} <- Data.delete_record(record) do
      send_resp(conn, :no_content, "")
    end
  end
end
