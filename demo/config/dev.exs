import Config

config :notioner,
  notion_req_options: [
    base_url: "https://api.notion.com/v1"
  ]

config :notioner, :granted_databases, %{
  default: "52dea0fc62ab477ba913f6a32526f96a",
  runner_tasks: "52dea0fc62ab477ba913f6a32526f96a",
  runner_projects: "fd0d6c7054d7462aac955d25a9c0af7b",
  reading_list: "408b771f00ff409e8bcab2c6c609b2a9",
  books: "6fd196b9edcd4ac1bd3f51057f12f89f"
}
