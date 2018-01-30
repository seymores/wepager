defmodule WePagerWeb.ProjectControllerTest do
  use WePagerWeb.ConnCase

  alias WePager.Data
  alias WePager.Data.Project

  @create_attrs %{expiry_date: ~N[2010-04-17 14:00:00.000000], meta: %{}, name: "some name", project_name_id: "some project_id"}
  @update_attrs %{expiry_date: ~N[2011-05-18 15:01:01.000000], meta: %{}, name: "some updated name", project_name_id: "some updated project_id"}
  @invalid_attrs %{expiry_date: nil, meta: nil, name: nil, project_name_id: nil}

  def fixture(:project) do
    {:ok, project} = Data.create_project(@create_attrs)
    project
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all projects", %{conn: conn} do
      conn = get conn, project_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create project" do
    test "renders project when data is valid", %{conn: conn} do
      conn = post conn, project_path(conn, :create), project: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, project_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "expiry_date" => "2010-04-17T14:00:00.000000",
        "meta" => %{},
        "name" => "some name",
        "project_name_id" => "some project_id"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, project_path(conn, :create), project: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update project" do
    setup [:create_project]

    test "renders project when data is valid", %{conn: conn, project: %Project{id: id} = project} do
      conn = put conn, project_path(conn, :update, project), project: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, project_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "expiry_date" => "2011-05-18T15:01:01.000000",
        "meta" => %{},
        "name" => "some updated name",
        "project_name_id" => "some updated project_id"}
    end

    test "renders errors when data is invalid", %{conn: conn, project: project} do
      conn = put conn, project_path(conn, :update, project), project: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete project" do
    setup [:create_project]

    test "deletes chosen project", %{conn: conn, project: project} do
      conn = delete conn, project_path(conn, :delete, project)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, project_path(conn, :show, project)
      end
    end
  end

  defp create_project(_) do
    project = fixture(:project)
    {:ok, project: project}
  end
end
