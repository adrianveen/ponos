defmodule PonosWeb.PageController do
  use PonosWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
