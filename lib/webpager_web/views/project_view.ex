defmodule WePagerWeb.ProjectView do
  use WePagerWeb, :view
  alias WePagerWeb.ProjectView

  def render("index.json", %{projects: projects}) do
    %{data: render_many(projects, ProjectView, "project.json")}
  end

  def render("show.json", %{project: project}) do
    %{data: render_one(project, ProjectView, "project.json")}
  end

  def render("project.json", %{project: project}) do
    %{id: project.id,
      expiry_date: project.expiry_date,
      meta: project.meta,
      name: project.name,
      project_name_id: project.project_name_id}
  end
end
