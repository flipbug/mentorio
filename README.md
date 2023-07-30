# Mentorio

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix


mix phx.gen.html Study Iteration iterations name theme purpose notes:text start_date:date end_date:date user_id:references:users

mix phx.gen.html Study Subject subjects name description:text user_id:references:users

mix phx.gen.html Study Session sessions notes:text iteration_id:references:iterations subject_id:references:subjects