defmodule Inventory do
  @moduledoc """
  Documentation for `Inventory`.
  """
  alias Inventory.{Books, Remarks}
  alias Inventory.Repo

  def start do
    IO.puts("Welcome, What do you want to do")

    choice =
      IO.gets("1. Add a Book\n2. update the reading status\n3. Delete the book\n4. Exit\n")
      |> String.trim_trailing()
      |> String.to_integer()

    case choice do
      1 ->
        add_a_book()

      2 ->
        update_reading_status()
        start()

      3 ->
        delete()
        start()

      4 ->
        IO.puts("Goodbye")
    end
  end

  def add_a_book do
    IO.puts("Adding a book")
    name = IO.gets("Enter the book name\n") |> String.trim_trailing()
    author = IO.gets("Enter the author name\n") |> String.trim_trailing()
    book = %Books{name: name, author: author}
    changeset = Books.changeset(book, %{})

    case Repo.insert(changeset) do
      {:ok, book} ->
        IO.puts("#{book.name} by #{book.author} added successfully")
        list_all_books()

      {:error, _} ->
        IO.puts("Please fill in proper values")
        add_a_book()
    end
  end

  def list_all_books do
    IO.puts("----------------------------------------")

    Enum.each(Repo.all(Books), fn book ->
      IO.puts(
        "ID #{book.id}. Book-name #{book.name} by author #{book.author} added date: #{book.inserted_at}"
      )
    end)

    IO.puts("----------------------------------------")
  end

  def add_remarks do
    list_all_books()

    id =
      IO.gets("Enter the ID corresponding to the book")
      |> String.to_integer()

    book = Repo.get(Books, id)
    IO.puts("Enter the remarks for #{book.name}")
    learnings = IO.gets("What did you learn from this book?\n")
    overall_satisfactory = IO.gets("How satisfied were you? (eg: good, very good, poor)\n")

    remarks = %Remarks{
      learnings: learnings,
      overall_satisfactory: overall_satisfactory,
      books_id: id
    }

    case Repo.insert(remarks) do
      {:ok, remarks} ->
        IO.puts("Remarks inserted successfully, satisfied: #{remarks.overall_satisfactory}")

      {:error, _} ->
        IO.puts("Please enter proper details")
    end
  end

  def update_reading_status do
    list_all_books()

    id =
      IO.gets("Enter the number corresponding to the book you want to update")
      |> String.to_integer()

    book = Repo.get(Books, id)

    completed =
      IO.gets("Have you completed reading #{book.name}? (yes) or (no)")
      |> String.trim_trailing()
      |> String.downcase()

    changeset = Books.changeset(book, %{completed: completed == "yes"})

    case Repo.update(changeset) do
      {:ok, book} ->
        IO.puts("#{book.name} by #{book.author} added successfully\nThe books in your database")
        list_all_books()

      {:error, _} ->
        IO.puts("Please fill in proper values")
        add_a_book()
    end
  end

  def delete do
    list_all_books()

    id =
      IO.gets("Enter the number corresponding to the book you want to update\n")
      |> String.trim_trailing()
      |> String.to_integer()

    book = Repo.get(Books, id)

    case Repo.delete(book) do
      {:ok, _} ->
        IO.puts("book deleted\n")
    end
  end
end
