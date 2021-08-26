defmodule Inventory.Repo.Migrations.CreateRemarks do
  use Ecto.Migration

  def change do
    create table(:remarks) do
      add :learnings, :text
      add :overall_satisfactory, :string
      add :book_id, references(:books, on_delete: :delete_all)
    end
  end
end
