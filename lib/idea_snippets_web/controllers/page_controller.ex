defmodule IdeaSnippetsWeb.PageController do
  use IdeaSnippetsWeb, :controller
  alias IdeaSnippets.Codes

  def index(conn, _params) do
    posts = Codes.list_posts()
    render(conn, "index.html", posts: posts)
  end
end
