defmodule WePagerWeb.RecordControllerTest do
  use WePagerWeb.ConnCase

  alias WePager.Data
  alias WePager.Data.Record

  @create_attrs %{body: %{test: true, embed: [1, 3, 4]}, meta_active: true, meta_name: "some meta_name", meta_order: 42, meta_type: "some meta_type"}
  @update_attrs %{body: %{test: false}, meta_active: false, meta_name: "some updated meta_name", meta_order: 43, meta_type: "some updated meta_type"}
  @invalid_attrs %{body: nil, meta_active: nil, meta_name: nil, meta_order: nil, meta_type: nil}

  def fixture(:record) do
    {:ok, project} = Data.create_project(%{expiry_date: nil, meta: %{}, name: "some name", project_name_id: "abcdefghjlk"})
    attrs = Map.merge(@create_attrs, %{project_id: project.id, project_name_id: project.project_name_id})

    {:ok, record} = Data.create_record(attrs)
    record
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all records", %{conn: conn} do
      conn = get conn, record_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create record" do
    test "renders record when data is valid", %{conn: conn} do
      {:ok, project} = Data.create_project(%{expiry_date: nil, meta: %{}, name: "some name", project_name_id: "abcdefghjlk"})
      attrs = Map.merge(@create_attrs, %{project_id: project.id, project_name_id: project.project_name_id})

      conn = post conn, record_path(conn, :create), record: attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, record_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "project_name_id" => "abcdefghjlk",
        "body" => %{"test" => true, "embed" => [1,3,4]},
        "meta_active" => true,
        "meta_name" => "some meta_name",
        "meta_order" => 42,
        "meta_type" => "some meta_type"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, record_path(conn, :create), record: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update record" do
    setup [:create_record]

    test "renders record when data is valid", %{conn: conn, record: %Record{id: id} = record} do
      conn = put conn, record_path(conn, :update, record), record: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, record_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "project_name_id" => "abcdefghjlk",
        "body" => %{"test" => false},
        "meta_active" => false,
        "meta_name" => "some updated meta_name",
        "meta_order" => 43,
        "meta_type" => "some updated meta_type"}
    end

    test "renders errors when data is invalid", %{conn: conn, record: record} do
      conn = put conn, record_path(conn, :update, record), record: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete record" do
    setup [:create_record]

    test "deletes chosen record", %{conn: conn, record: record} do
      conn = delete conn, record_path(conn, :delete, record)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, record_path(conn, :show, record)
      end
    end
  end

  defp create_record(_) do
    record = fixture(:record)
    {:ok, record: record}
  end
end
