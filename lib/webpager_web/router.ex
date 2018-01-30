defmodule WePagerWeb.Router do
  use WePagerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", WePagerWeb do
    pipe_through :api

    resources "/records", RecordController, except: [:new, :edit]
    resources "/projects", ProjectController, except: [:new, :edit]
  end
end
