defmodule Inventory.Repo.Migrations.AddReadingStatus do
  use Ecto.Migration

  def change do
    alter table("books") do
      add :completed, :boolean
    end
  end
end
