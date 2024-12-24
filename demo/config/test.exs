import Config

config :notioner,
  notion_req_options: [
    base_url: "https://mock-api.notion.com/v1",
    plug: {Req.Test, Notioner}
  ]

config :logger, level: :warning
