defmodule MentorioWeb.IterationDetailLive do
  use MentorioWeb, :live_view

  alias Mentorio.Study
  alias Mentorio.Study.Session
  alias Mentorio.Study.Iteration

  def mount(params, _session, socket) do
    %{"id" => id} = params
    changeset = Study.change_iteration_notes(%Iteration{})

    {:ok,
     socket
     |> assign(:iteration, Study.get_iteration!(id))
     |> assign(:changeset, to_form(changeset))
     |> assign(:edit_notes, false)}
  end

  def render(assigns) do
    ~H"""
    <div class="flex gap-4">
      <div class="w-3/4">
        <h2 class="text-4xl font-display"><%= @iteration.theme %></h2>
        <h3 class="text-3xl text-indigo-500 font-display"><%= @iteration.purpose %></h3>
        <div class="text-sm text-neutral-500 dark:text-neutral-300">
          <MentorioWeb.Helper.formattedDate date={@iteration.start_date} /> -
          <MentorioWeb.Helper.formattedDate date={@iteration.end_date} />
        </div>

        <div class="mt-8 mb-4">
          <%= if @edit_notes do %>
            <.simple_form
              :let={f}
              phx-submit="update_notes"
              id="update_notes"
              for={@changeset}
              action={@changeset.action}
            >
              <.error :if={@changeset.action}>
                Oops, something went wrong! Please check the errors below.
              </.error>
              <.input
                type="textarea"
                name="notes"
                placeholder="Notes..."
                value={@iteration.notes}
                field={f[:notes]}
              />
              <input type="hidden" name="iteration_id" value={@iteration.id} />

              <.button type="submit">Save</.button>
              <.button type="button" phx-click="cancel_notes" class="bg-slate-700 hover:bg-slate-800">
                Cancel
              </.button>
            </.simple_form>
          <% else %>
            <p class="mb-2"><%= @iteration.notes %></p>
            <.button phx-click="edit_notes">Edit Notes</.button>
          <% end %>
        </div>

        <div class="mt-10 text-2xl">Sessions</div>
        <%= if @iteration.sessions |> length > 0 do %>
          <ol class="border-l border-gray-100 dark:border-gray-500 mt-5 ml-2">
            <li :for={session <- @iteration.sessions}>
              <div class="flex-start flex items-center pt-3">
                <div class="-ml-[5px] mr-6 h-[9px] w-[9px] rounded-full bg-indigo-300 dark:bg-indigo-500" />
                <p class="text-sm text-neutral-500 dark:text-neutral-300">
                  <MentorioWeb.Helper.formattedDate date={session.inserted_at} />
                </p>
              </div>
              <div class="mb-6 ml-8 mt-2 ">
                <div class="flex justify-between">
                  <h4 class="block mb-1.5 text-xl font-semibold"><%= session.subject.name %></h4>
                  <div>
                    <button
                      class="bg-rose-900 hover:bg-rose-600 rounded-lg px-2 py-2 align-middle flex"
                      phx-click="delete_session"
                      phx-value-session-id={session.id}
                      phx-value-iteration-id={@iteration.id}
                    >
                      <.icon name="hero-trash" class="h-4 w-4" />
                    </button>
                  </div>
                </div>

                <p class="my-3 text-neutral-500 dark:text-neutral-300">
                  <%= session.subject.description %>
                </p>
                <!-- <p class="my-3 text-neutral-500 dark:text-neutral-300">add notes</p> -->
              </div>
            </li>
          </ol>
        <% else %>
          <div class="text-slate-500 mt-4">No sessions recorded yet.</div>
        <% end %>
      </div>
      <div class="w-1/4">
        <.live_component
          module={MentorioWeb.SubjectsComponentLive}
          id="subjects"
          iteration_id={@iteration.id}
          user_id={@current_user.id}
        />
      </div>
    </div>
    """
  end

  def handle_event("edit_notes", _, socket) do
    {:noreply,
     socket
     |> assign(:edit_notes, true)}
  end

  def handle_event("cancel_notes", _, socket) do
    {:noreply,
     socket
     |> assign(:edit_notes, false)}
  end

  def handle_event("update_notes", %{"notes" => notes, "iteration_id" => iteration_id}, socket) do
    case Study.update_iteration_notes(
           %Iteration{:id => iteration_id |> String.to_integer()},
           %{:notes => notes}
         ) do
      {:ok, _iteration} ->
        {:noreply,
         socket
         |> assign(:edit_notes, false)
         |> assign(:iteration, Study.get_iteration!(iteration_id))}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: to_form(changeset))}
    end
  end

  def handle_event(
        "delete_session",
        %{"session-id" => session_id, "iteration-id" => iteration_id},
        socket
      ) do
    case Study.delete_session(%Session{:id => session_id |> String.to_integer()}) do
      {:ok, _session} ->
        {:noreply,
         socket
         |> assign(:iteration, Study.get_iteration!(iteration_id))}

      {:error, _changeset} ->
        {:noreply, socket |> put_flash(:error, "Could not create session")}
    end
  end
end
