import Config

config :notioner,
  notion_req_options: [
    base_url: "https://api.notion.com/v1",
    auth: {:bearer, System.fetch_env!("NOTIONER_ACCESS_TOKEN")}
  ]
