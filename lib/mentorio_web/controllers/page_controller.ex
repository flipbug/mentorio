defmodule MentorioWeb.PageController do
  use MentorioWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    conn
    |> render(:home, layout: false)
  end
end
