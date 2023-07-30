defmodule MentorioWeb.IterationHTML do
  use MentorioWeb, :html

  embed_templates "iteration_html/*"

  @doc """
  Renders a iteration form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def iteration_form(assigns)
end
