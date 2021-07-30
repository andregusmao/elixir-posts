defmodule BlogWeb.PostController do
  use BlogWeb, :controller
  alias Blog.{Posts, Posts.Post}

  action_fallback BlogWeb.FallbackController

  def index(conn, _) do
    render(conn, "index.json", posts: Posts.list_posts())
  end

  def show(conn, %{"id" => id}) do
    render(conn, "show.json", post: Posts.get_post!(id))
  end

  def create(conn,%{"post" => post}) do
    with {:ok, %Post{} = post} <- Posts.create_post(post) do
      conn
      |>put_status(:created)
      |>put_resp_header("location", Routes.post_path(conn, :show, post))
      |>render("show.json", post: post)
    end
  end

  def update(conn,%{"id" => id, "post" => post_params}) do
    post = Posts.get_post!(id)
    with {:ok, %Post{} = post} <- Posts.update_post(post, post_params) do
      conn
      |>put_status(:ok)
      |>put_resp_header("location", Routes.post_path(conn, :show, post))
      |>render("show.json", post: post)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Posts.get_post!(id)
    with {:ok, %Post{}} <- Posts.delete_post(post) do
      send_resp(conn, :no_content, "")
    end
  end
end
