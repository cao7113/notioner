import Config

config :notioner,
  notion_req_options: [
    # base_url: "https://api.notion.com/v1",
    headers: [
      # https://developers.notion.com/reference/versioning
      "Notion-Version": "2022-06-28",
      # https://www.notion.so/profile/integrations/internal/58e2844c-d10d-4fe6-b161-29f299e014a3
      # Authorization: "Bearer #{System.get_env("NOTIONER_ACCESS_TOKEN")}",
      accept: "application/json"
    ],
    auth:
      {:bearer, System.get_env("NOTIONER_ACCESS_TOKEN", "not found env: NOTIONER_ACCESS_TOKEN")}
  ]
