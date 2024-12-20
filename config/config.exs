import Config

# Demo internal integration data-helper('notion' word not allowed)
# - https://www.notion.so/profile/integrations/internal/58e2844cd10d4fe6b16129f299e014a3
# - https://www.notion.so/shareupme/408b771f00ff409e8bcab2c6c609b2a9?v=328c08a080ab428c8a161f8f85132476&pvs=4
# Note:
# - all below database should be granted to above integration.
# - all children pages(database rows) automatically granted after previous grant!
config :notioner, :granted_databases, %{
  run_man_projects: "fd0d6c7054d7462aac955d25a9c0af7b",
  run_man_tasks: "52dea0fc62ab477ba913f6a32526f96a",
  reading_list: "408b771f00ff409e8bcab2c6c609b2a9"
}
