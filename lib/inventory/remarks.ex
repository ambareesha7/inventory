defmodule Inventory.Remarks do
  use Ecto.Schema
  import Ecto.Changeset

  schema "remarks" do
    field(:learnings, :string)
    field(:overall_satisfactory, :string)
    belongs_to(:books, Inventory.Books)
  end

  def changeset(remarks, params \\ %{}) do
    remarks
    |> cast(params, [:learning, :overall_satisfactory, :book_id])
    |> validate_required([:learning, :overall_satisfactory])
  end
end
