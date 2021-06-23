defmodule IdeaSnippets.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :description, :string
      add :code, :text

      timestamps()
    end

  end
end
