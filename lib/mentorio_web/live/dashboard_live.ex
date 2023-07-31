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
    <div class="flex gap-4">
      <div class="w-3/4">
        <div class="mb-5">
          <div class="font-display text-4xl font-bold">
            Welcome back <span class="text-indigo-500"><%= @current_user.firstname %></span>!
          </div>
        </div>

        <div class="mb-10 rounded-lg p-5 bg-slate-800">
          <div class="text-lg">
            <span class="text-indigo-500"></span> No Iteration in progress
          </div>
          <a href="/iterations/new" class="block mt-8">
            <.button>Create Iteration</.button>
          </a>
        </div>

        <div class="flex flex-row flex-wrap">
          <div :for={iteration <- @iterations}>
            <p><%= iteration.theme %></p>
          </div>
        </div>
      </div>

      <div class="w-1/4"></div>
    </div>
    """
  end
end
