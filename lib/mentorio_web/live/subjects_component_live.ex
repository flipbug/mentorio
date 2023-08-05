defmodule MentorioWeb.SubjectsComponentLive do
  use MentorioWeb, :live_component

  alias Mentorio.Study

  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(:subjects, Study.list_subjects(assigns.user_id))
     |> assign(:iteration_id, Map.get(assigns, :iteration_id, nil))}
  end

  def render(assigns) do
    ~H"""
    <div>
      <h2 class="font-display text-2xl ml-8 mb-4">New Session</h2>

      <.link navigate={~p"/dashboard/subjects/new"}>
        <div class="p-4 mb-4 border-2 border-slate-800 rounded-lg ml-8 hover:bg-indigo-500 hover:cursor-pointer">
          <.icon name="hero-plus-circle" class="h-5 w-5" /> Add Subject
        </div>
      </.link>

      <%= if @iteration_id do %>
        <div
          :for={subject <- @subjects}
          class="p-4 mb-4 bg-slate-800 rounded-lg ml-8 ml-8 hover:ml-4 hover:mr-4 ease-out duration-300 hover:cursor-pointer"
          phx-click="new_session"
          phx-value-subject-id={subject.id}
          phx-value-iteration-id={@iteration_id}
          phx-target={@myself}
        >
          <div><%= subject.name %></div>
          <%!-- <div class="flex flex-wrap gap-2">
    			<Tag>{tag.name}</Tag>
    </div> --%>
        </div>
      <% else %>
        <div
          :for={subject <- @subjects}
          class="p-4 mb-4 bg-slate-800 rounded-lg ml-8 hover:cursor-not-allowed"
          title="No iteration in progress"
        >
          <div><%= subject.name %></div>
          <%!-- <div class="flex flex-wrap gap-2">
    			<Tag>{tag.name}</Tag>
    </div> --%>
        </div>
      <% end %>
    </div>
    """
  end

  def handle_event(
        "new_session",
        %{"subject-id" => subject_id, "iteration-id" => iteration_id},
        socket
      ) do
    case Study.create_session(%{:subject_id => subject_id, :iteration_id => iteration_id}) do
      {:ok, _session} ->
        {:noreply,
         socket
         |> put_flash(:info, "Session created")
         |> push_navigate(to: ~p"/dashboard/iterations/#{iteration_id}")}

      {:error, _changeset} ->
        {:noreply, socket |> put_flash(:error, "Could not create session")}
    end
  end
end
