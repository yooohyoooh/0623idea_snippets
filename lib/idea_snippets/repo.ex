defmodule IdeaSnippets.Repo do
  use Ecto.Repo,
    otp_app: :idea_snippets,
    adapter: Ecto.Adapters.Postgres
end
