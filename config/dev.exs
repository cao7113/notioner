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

config :git_ops,
  mix_project: Mix.Project.get!(),
  changelog_file: "CHANGELOG.md",
  repository_url: "https://github.com/cao7113/notioner",
  types: [
    # Makes an allowed commit type called `tidbit` that is not
    # shown in the changelog
    tidbit: [
      hidden?: true
    ],
    # Makes an allowed commit type called `important` that gets
    # a section in the changelog with the header "Important Changes"
    important: [
      header: "Important Changes"
    ]
  ],
  tags: [
    # Only add commits to the changelog that has the "backend" tag
    allowed: ["backend"],
    # Filter out or not commits that don't contain tags
    allow_untagged?: true
  ],
  # Instructs the tool to manage your mix version in your `mix.exs` file
  # See below for more information
  manage_mix_version?: true,
  # Instructs the tool to manage the version in your README.md
  # Pass in `true` to use `"README.md"` or a string to customize
  manage_readme_version: "README.md",
  version_tag_prefix: "v"
