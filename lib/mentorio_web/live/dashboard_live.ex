defmodule MentorioWeb.DashboardLive do
  alias Mentorio.Study
  alias Mentorio.Study.Iteration

  use MentorioWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, today} = DateTime.now("Etc/UTC")

    iterations = Study.list_iterations(socket.assigns.current_user.id)

    current_iteration =
      iterations
      |> Enum.find(iterations, fn x ->
        Date.compare(x.start_date, today) == :lt &&
          Date.compare(x.end_date, today) == :gt
      end)
      |> case do
        %Iteration{} = iteration -> Map.put(iteration, :progress, 10)
        _ -> nil
      end

    {:ok,
     socket
     |> assign(:iterations, Study.list_iterations(socket.assigns.current_user.id))
     |> assign(:current_iteration, current_iteration)}
  end

  def render(assigns) do
    ~H"""
    <div class="flex gap-4">
      <div class="w-3/4">
        <div class="mb-5">
          <div class="font-display text-4xl font-light ">
            Welcome back <span class="text-indigo-500 font-normal"><%= @current_user.firstname %></span>!
          </div>
        </div>

        <%= if @current_iteration do %>
          <.link navigate={~p"/dashboard/iterations/#{@current_iteration.id}"}>
            <div class="mb-10 rounded-lg p-5 bg-slate-800 hover:bg-slate-700">
              <div class="inline-flex items-center justify-center rounded-full bg-emerald-100 px-2.5 py-0.5 text-emerald-700 text-xs mb-4">
                In Progress
              </div>
              <h2 class="text-4xl font-display font-bold">
                <%= @current_iteration.theme %>
              </h2>
              <h3 class="text-3xl text-indigo-500 font-display mb-2">
                <%= @current_iteration.purpose %>
              </h3>
              <div class="text-sm text-gray-500 dark:text-gray-300">
                <MentorioWeb.Helper.formattedDate date={@current_iteration.start_date} /> -
                <MentorioWeb.Helper.formattedDate date={@current_iteration.end_date} />
              </div>

              <div class="mt-5">
                <span id="ProgressLabel" class="sr-only">Loading</span>

                <span
                  role="progressbar"
                  aria-labelledby="ProgressLabel"
                  aria-valuenow={@current_iteration.progress}
                  class="block rounded-full bg-slate-900"
                >
                  <span
                    class="block h-3 rounded-full bg-indigo-600"
                    style={"width: #{@current_iteration.progress}%"}
                  />
                </span>
              </div>
            </div>
          </.link>
        <% else %>
          <div class="mb-10 rounded-lg p-5 bg-slate-800">
            <div class="text-lg">
              <span class="text-indigo-500"></span> No Iteration in progress
            </div>
            <a href={~p"/dashboard/iterations/new"} class="block mt-8">
              <.button>Create Iteration</.button>
            </a>
          </div>
        <% end %>

        <div class="flex flex-row flex-wrap gap-2">
          <div :for={iteration <- @iterations} class="md:w-1/2 lg:w-1/3">
              <section class="dark:hover:bg-slate-800 rounded-lg basis-1/3">
              <.link navigate={~p"/dashboard/iterations/#{iteration.id}"} class="block p-5">
                  <h2 class="text-3xl font-bold font-display tracking-tight {isFinished ? 'text-slate-600' : ''}">
                    <%= iteration.theme %>
                  </h2>

                  <div class="mb-2 text-sm text-gray-400">
                    <MentorioWeb.Helper.formattedDate date={iteration.start_date} /> -
                    <MentorioWeb.Helper.formattedDate date={iteration.end_date} />
                  </div>

                  <p class="leading-tight text-xl text-indigo-500"><%= iteration.purpose %></p>
                  </.link>
              </section>
          </div>
        </div>
      </div>

      <div class="w-1/4 mt-2">
        <.live_component
          module={MentorioWeb.SubjectsComponentLive}
          id="subjects"
          iteration_id={@current_iteration.id}
          user_id={@current_user.id}
        />
      </div>
    </div>
    """
  end
end
