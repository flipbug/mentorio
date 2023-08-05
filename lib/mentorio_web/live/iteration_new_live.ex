defmodule MentorioWeb.IterationNewLive do
  use MentorioWeb, :live_view

  alias Mentorio.Study
  alias Mentorio.Study.Iteration

  def mount(_params, _session, socket) do
    changeset = Study.change_iteration(%Iteration{})

    {:ok,
     socket
     |> assign(:changeset, to_form(changeset))}
  end

  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-2xl">
      <.header>
        New Iteration
        <:subtitle>
          Define a clear theme and the purpose behind it. This will help you focus and stay motivated.
        </:subtitle>
      </.header>

      <.simple_form
        :let={f}
        for={@changeset}
        action={@changeset.action}
        id="iteration_form"
        phx-submit="create_iteration"
      >
        <.error :if={@changeset.action}>
          Oops, something went wrong! Please check the errors below.
        </.error>
        <.input field={f[:theme]} type="text" label="Theme" />
        <.input field={f[:purpose]} type="text" label="Purpose" />
        <.input field={f[:notes]} type="textarea" label="Notes" />
        <.input field={f[:start_date]} type="date" label="Start date" />
        <.input field={f[:end_date]} type="date" label="End date" />
        <:actions>
          <.button>Save Iteration</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  def handle_event("create_iteration", params, socket) do
    user = socket.assigns.current_user

    case Study.create_iteration(Map.put(params, "user_id", user.id)) do
      {:ok, _iteration} ->
        {:noreply,
         socket
         |> put_flash(:info, "Iteration created")
         |> redirect(to: ~p"/dashboard")}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: to_form(changeset))}
    end
  end
end
