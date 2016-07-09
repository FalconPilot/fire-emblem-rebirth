use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :forum, Forum.Endpoint,
  secret_key_base: "iV6JpgQ4y7cl3QBCC664J9CE6KhyhPT4HyPND1VpVXoXeOJdim5TUXzxtGYtLPX+"

# Configure your database
config :forum, Forum.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "forum_prod",
  pool_size: 20
