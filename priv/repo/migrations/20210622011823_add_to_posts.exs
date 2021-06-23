defmodule IdeaSnippets.Repo.Migrations.AddToPosts do
  use Ecto.Migration

  def change do
    #データ型の登録、削除クエリを作成→？？？
    create_query = "create type published_status as enum('draft', 'public', 'limited', 'private')"
    drop_query = "drop type published_status"
    execute(create_query, drop_query)

    #スキーマへの実行add->migrateで追加
    alter table(:posts) do
      add :published, :published_status
      add :user_id, :integer
    end
  end
end
