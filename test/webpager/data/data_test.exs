defmodule WePager.DataTest do
  use WePager.DataCase

  alias WePager.Data

  describe "records" do
    alias WePager.Data.Record

    @valid_attrs %{api_id: "some api_id", body: %{}, project_id: nil, project_name_id: nil, meta_active: true, meta_name: "some meta_name", meta_order: 42, meta_type: "some meta_type"}
    @update_attrs %{api_id: "some updated api_id", body: %{}, meta_active: false, meta_name: "some updated meta_name", meta_order: 43, meta_type: "some updated meta_type"}
    @invalid_attrs %{api_id: nil, body: nil, meta_active: nil, meta_name: nil, meta_order: nil, meta_type: nil}

    def record_fixture(attrs \\ %{}) do
      project = project_fixture()

      {:ok, record} =
        attrs
        |> Enum.into(%{project_id: project.id, project_name_id: project.project_name_id})
        |> Enum.into(@valid_attrs)
        |> Data.create_record()

      record
    end

    test "list_records/0 returns all records" do
      record = record_fixture()
      assert Data.list_records() == [record]
    end

    test "get_record!/1 returns the record with given id" do
      record = record_fixture()
      assert Data.get_record!(record.id) == record
    end

    test "create_record/1 with valid data creates a record" do
      project = project_fixture()
      attrs = Map.merge(@valid_attrs, %{project_id: project.id, project_name_id: project.project_name_id})

      assert {:ok, %Record{} = record} = Data.create_record(attrs)
      assert record.body == %{}
      assert record.meta_active == true
      assert record.meta_name == "some meta_name"
      assert record.meta_order == 42
      assert record.meta_type == "some meta_type"
    end

    test "create_record/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Data.create_record(@invalid_attrs)
    end

    test "update_record/2 with valid data updates the record" do
      record = record_fixture()

      assert {:ok, record} = Data.update_record(record, @update_attrs)
      assert %Record{} = record
      assert record.body == %{}
      assert record.meta_active == false
      assert record.meta_name == "some updated meta_name"
      assert record.meta_order == 43
      assert record.meta_type == "some updated meta_type"
    end

    test "update_record/2 with invalid data returns error changeset" do
      record = record_fixture()
      assert {:error, %Ecto.Changeset{}} = Data.update_record(record, @invalid_attrs)
      assert record == Data.get_record!(record.id)
    end

    test "delete_record/1 deletes the record" do
      record = record_fixture()
      assert {:ok, %Record{}} = Data.delete_record(record)
      assert_raise Ecto.NoResultsError, fn -> Data.get_record!(record.id) end
    end

    test "change_record/1 returns a record changeset" do
      record = record_fixture()
      assert %Ecto.Changeset{} = Data.change_record(record)
    end
  end

  describe "projects" do
    alias WePager.Data.Project

    @valid_attrs %{expiry_date: ~N[2010-04-17 14:00:00.000000], meta: %{}, name: "some name", project_name_id: "abcdefghjlk"}
    @update_attrs %{expiry_date: ~N[2011-05-18 15:01:01.000000], meta: %{}, name: "some updated name"}
    @invalid_attrs %{expiry_date: nil, meta: nil, name: nil,  project_name_id: nil}

    def project_fixture(attrs \\ %{}) do
      {:ok, project} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Data.create_project()

      project
    end

    test "list_projects/0 returns all projects" do
      project = project_fixture()
      assert Data.list_projects() == [project]
    end

    test "get_project!/1 returns the project with given id" do
      project = project_fixture()
      assert Data.get_project!(project.id) == project
    end

    test "create_project/1 with valid data creates a project" do
      assert {:ok, %Project{} = project} = Data.create_project(@valid_attrs)
      assert project.expiry_date == ~N[2010-04-17 14:00:00.000000]
      assert project.meta == %{}
      assert project.name == "some name"
    end

    test "create_project/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Data.create_project(@invalid_attrs)
    end

    test "update_project/2 with valid data updates the project" do
      project = project_fixture()
      assert {:ok, project} = Data.update_project(project, @update_attrs)
      assert %Project{} = project
      assert project.expiry_date == ~N[2011-05-18 15:01:01.000000]
      assert project.meta == %{}
      assert project.name == "some updated name"
    end

    test "update_project/2 with invalid data returns error changeset" do
      project = project_fixture()
      assert {:error, %Ecto.Changeset{}} = Data.update_project(project, @invalid_attrs)
      assert project == Data.get_project!(project.id)
    end

    test "delete_project/1 deletes the project" do
      project = project_fixture()
      assert {:ok, %Project{}} = Data.delete_project(project)
      assert_raise Ecto.NoResultsError, fn -> Data.get_project!(project.id) end
    end

    test "change_project/1 returns a project changeset" do
      project = project_fixture()
      assert %Ecto.Changeset{} = Data.change_project(project)
    end
  end
end
