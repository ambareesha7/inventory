import Config

config :inventory,
  ecto_repos: [Inventory.Repo]

config :inventory, Inventory.Repo,
  database: "inventory_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"
