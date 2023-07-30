defmodule MentorioWeb.SessionHTML do
  use MentorioWeb, :html

  embed_templates "session_html/*"

  @doc """
  Renders a session form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def session_form(assigns)
end
