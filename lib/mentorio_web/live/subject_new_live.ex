defmodule MentorioWeb.SubjectsNewLive do
  use MentorioWeb, :live_view

  alias Mentorio.Study
  alias Mentorio.Study.Subject

  def mount(_params, _session, socket) do
    changeset = Study.change_subject(%Subject{})

    {:ok,
     socket
     |> assign(:changeset, to_form(changeset))}
  end

  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-2xl">
      <.header>
        New Subject
        <:subtitle>
          A subject is something you want to focus on during your iteration.
          It can be general or specific, but clear enough to be actionable.
        </:subtitle>
      </.header>

      <.simple_form
        :let={f}
        for={@changeset}
        action={@changeset.action}
        id="subject_form"
        phx-submit="create_subject"
      >
        <.error :if={@changeset.action}>
          Oops, something went wrong! Please check the errors below.
        </.error>
        <.input field={f[:name]} type="text" label="Name" />
        <.input field={f[:description]} type="textarea" label="Description" />
        <:actions>
          <.button>Save Subject</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  def handle_event("create_subject", params, socket) do
    user = socket.assigns.current_user

    case Study.create_subject(Map.put(params, "user_id", user.id)) do
      {:ok, _iteration} ->
        {:noreply,
         socket
         |> put_flash(:info, "Subject created")
         |> redirect(to: ~p"/dashboard")}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: to_form(changeset))}
    end
  end
end
