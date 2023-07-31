defmodule MentorioWeb.DashboardLive do
  alias Mentorio.Study
  use MentorioWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:iterations, Study.list_iterations())
     |> assign(:subjects, Study.list_subjects())}
  end

  def render(assigns) do
    ~H"""
    <h1>Welcome back <%= @current_user.firstname %>! </h1>
    <p>Hello world</p>

    <div :for={iteration <- @iterations}>
      <p><%= iteration.theme %></p>
    </div>
    """
  end
end
