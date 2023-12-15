defmodule EndpointDBWeb.Router do
  use EndpointDBWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", EndpointDBWeb do
    pipe_through :api
  end
end
