defmodule IdeaSnippets.Codes do
  @moduledoc """
  The Codes context.
  """

  import Ecto.Query, warn: false
  alias IdeaSnippets.Repo

  alias IdeaSnippets.Codes.Post
  alias IdeaSnippets.Comments

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts do
    [draft, _public, _limited, private] = Ecto.Enum.values(Post, :published)
    Post
    |> where([p], p.published != ^draft)
    |> where([p], p.published != ^private)
    |> order_by([p], [desc: p.updated_at])
    |> Repo.all()
  end

  def list_posts(id) do
    Post
    |> where([p], p.user_id == ^id)
    |> order_by([p], [desc: p.updated_at])
    |> Repo.all
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(id), do: Repo.get!(Post, id)

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(attrs \\ %{}) do
    IO.puts("**----------")
    IO.puts("on Codes.create_post")
    IO.inspect(attrs)
    IO.puts("----------**")
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{data: %Post{}}

  """
  def change_post(%Post{} = post, attrs \\ %{}) do
    Post.changeset(post, attrs)
  end

  def add_comment(post_id, comment_params) do
    comment_params
    |> Map.put("post_id", post_id) #put(map, key, value)
    |> Comments.create_comment()
  end

  def get_comments(post_id), do: Repo.preload(get_post!(post_id), [:comments])
end
