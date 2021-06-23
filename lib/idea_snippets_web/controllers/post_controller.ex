defmodule IdeaSnippetsWeb.PostController do
  use IdeaSnippetsWeb, :controller

  alias IdeaSnippets.Codes
  alias IdeaSnippets.Codes.Post
  # alias IdeaSnippets.Repo
  alias IdeaSnippets.Comments.Comment

  def index(conn, _params) do
    # IO.puts("**----------")
    # IO.puts("on post_controller.index")
    # IO.inspect(conn)
    # IO.puts("----------**")
    posts = Codes.list_posts(conn.assigns.current_user.id)
    IO.inspect(posts)
    render(conn, "index.html", posts: posts)
  end

  def new(conn, _params) do
    changeset = Codes.change_post(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    case Codes.create_post(post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Codes.get_comments(id)
    changeset = Comment.changeset(%Comment{}, %{})
    render(conn, "show.html", post: post, changeset: changeset)
  end

  def edit(conn, %{"id" => id}) do
    post = Codes.get_post!(id)
    changeset = Codes.change_post(post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Codes.get_post!(id)

    case Codes.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Codes.get_post!(id)
    {:ok, _post} = Codes.delete_post(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: Routes.post_path(conn, :index))
  end

  def add_comment(conn, %{"comment" => comment_params, "post_id" => post_id}) do
    IO.puts("**----------")
    IO.inspect(comment_params)
    IO.inspect(post_id)
    IO.puts("----------**")
    # **----------
    # %{"content" => "test", "name" => "test"}
    # "5"
    # ----------**


    post = Codes.get_comments(post_id)
    # post_id
    # |> Codes.get_post!() #idからpostを取得@codes.ex
    # |> Repo.preload([:comments]) #preloadしないと対応するcommentsを持って来れない

    case Codes.add_comment(post_id, comment_params) do
      {:ok, _comment} ->
        conn
        |> put_flash(:info, "Comment added successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, _error} ->
        conn
        |> put_flash(:info, "Comment not added :( ")
        |> redirect(to: Routes.post_path(conn, :show, post))
    end
  end
end
