defmodule WePagerWeb.Router do
  use WePagerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", WePagerWeb do
    pipe_through :api

    resources "/records", RecordController, except: [:new, :edit]
    resources "/projects", ProjectController, except: [:new, :edit]

    get "/:project_name_id/:meta_type", PublicController, :index
    get "/:project_name_id/:meta_type/:id", PublicController, :show
    post "/:project_name_id/:meta_type", PublicController, :create
    put "/:project_name_id/:meta_type/:id", PublicController, :update
    patch "/:project_name_id/:meta_type", PublicController, :update
    delete "/:project_name_id/:meta_type", PublicController, :delete

  end
end
