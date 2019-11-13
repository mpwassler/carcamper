defmodule SwStoreWeb.PageController do
  use SwStoreWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
