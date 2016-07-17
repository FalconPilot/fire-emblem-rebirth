use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :fer_forum, FerForum.Endpoint,
  secret_key_base: "63YZ/21Quo4VEkikuTFx7UMIc/vRijRBZj1Z5gblWI8xkYFzBI+CyNBRMY2I70wt"

# Configure your database
config :fer_forum, FerForum.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "fer_forum_prod",
  pool_size: 20
