defmodule BlogWeb.FallbackController do
  use BlogWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |>put_status(:unprocessable_entity)
    |>put_view(BlogWeb.ChangesetView)
    |>render("error.json", changeset: changeset)
  end
end
