defmodule IdeaSnippetsWeb.PageView do
  use IdeaSnippetsWeb, :view

  alias IdeaSnippets.Codes

  def get_number_of_comments(post_id) do
    post = Codes.get_comments(post_id)
    Enum.count(post.comments)
  end

  def parse_markdown(markdown) do
    Earmark.as_html!(markdown, %Earmark.Options{code_class_prefix: "lang-", smartypants: false})
  end
end
