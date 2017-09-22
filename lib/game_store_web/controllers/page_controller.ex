defmodule GameStoreWeb.PageController do
  use GameStoreWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
