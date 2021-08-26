defmodule Inventory.Books do
  use Ecto.Schema
  import Ecto.Changeset

  schema "books" do
    field(:name, :string)
    field(:author, :string)
    field(:completed, :boolean, default: false)
    has_one(:remarks, Inventory.Remarks)

    timestamps()
  end

  def changeset(books, params \\ %{}) do
    books
    |> cast(params, [:name, :author, :completed])
    |> validate_required([:name, :author])
  end
end
