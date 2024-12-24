defmodule Notioner.PageTest do
  use ExUnit.Case

  alias Notioner.Page, as: Page

  describe "get page" do
    test "ok" do
      mock_body = %{
        "archived" => false,
        "cover" => nil,
        "created_by" => %{
          "id" => "a1a07517-b528-439d-91d0-50a809b1a23f",
          "object" => "user"
        },
        "created_time" => "2024-12-18T08:15:00.000Z",
        "icon" => %{
          "external" => %{
            "url" => "https://www.notion.so/icons/clipping_lightgray.svg"
          },
          "type" => "external"
        },
        "id" => "160673e5-9ab6-80c0-b090-cf8b8b4758e0",
        "in_trash" => false,
        "last_edited_by" => %{
          "id" => "58e2844c-d10d-4fe6-b161-29f299e014a3",
          "object" => "user"
        },
        "last_edited_time" => "2024-12-20T11:40:00.000Z",
        "object" => "page",
        "parent" => %{
          "database_id" => "52dea0fc-62ab-477b-a913-f6a32526f96a",
          "type" => "database_id"
        },
        "properties" => %{
          "Assignee" => %{
            "id" => "notion%3A%2F%2Ftasks%2Fassign_property",
            "people" => [],
            "type" => "people"
          },
          "Checked" => %{
            "checkbox" => false,
            "id" => "0935a791-ca68-4901-a3c2-556f24e5ebce",
            "type" => "checkbox"
          },
          "Completed on" => %{"date" => nil, "id" => "%60d%3Bl", "type" => "date"},
          "Created time" => %{
            "created_time" => "2024-12-18T08:15:00.000Z",
            "id" => "%5C%3A~A",
            "type" => "created_time"
          },
          "Delay" => %{
            "formula" => %{"string" => nil, "type" => "string"},
            "id" => "%5B%3EkY",
            "type" => "formula"
          },
          "Due" => %{
            "date" => nil,
            "id" => "notion%3A%2F%2Ftasks%2Fdue_date_property",
            "type" => "date"
          },
          "ID" => %{
            "id" => "MF~g",
            "type" => "unique_id",
            "unique_id" => %{"number" => 211, "prefix" => nil}
          },
          "ID-Title" => %{
            "formula" => %{"string" => "211-Testing notion task", "type" => "string"},
            "id" => "GYYb",
            "type" => "formula"
          },
          "Last edited time" => %{
            "id" => "Ddpb",
            "last_edited_time" => "2024-12-20T11:40:00.000Z",
            "type" => "last_edited_time"
          },
          "Parent-task" => %{
            "has_more" => false,
            "id" => "notion%3A%2F%2Ftasks%2Fparent_task_relation",
            "relation" => [%{"id" => "15f673e5-9ab6-80f4-827c-f62002732162"}],
            "type" => "relation"
          },
          "Priority" => %{
            "id" => "notion%3A%2F%2Ftasks%2Fpriority_property",
            "select" => nil,
            "type" => "select"
          },
          "Project" => %{
            "has_more" => false,
            "id" => "notion%3A%2F%2Ftasks%2Ftask_to_project_relation",
            "relation" => [%{"id" => "15f673e5-9ab6-8058-9c88-d2c429bc0314"}],
            "type" => "relation"
          },
          "Status" => %{
            "id" => "notion%3A%2F%2Ftasks%2Fstatus_property",
            "status" => %{"color" => "green", "id" => "done", "name" => "Done"},
            "type" => "status"
          },
          "Sub-tasks" => %{
            "has_more" => false,
            "id" => "notion%3A%2F%2Ftasks%2Fsub_task_relation",
            "relation" => [],
            "type" => "relation"
          },
          "Tags" => %{
            "id" => "notion%3A%2F%2Ftasks%2Ftags_property",
            "multi_select" => [],
            "type" => "multi_select"
          },
          "Task name" => %{
            "id" => "title",
            "title" => [
              %{
                "annotations" => %{
                  "bold" => false,
                  "code" => false,
                  "color" => "default",
                  "italic" => false,
                  "strikethrough" => false,
                  "underline" => false
                },
                "href" => nil,
                "plain_text" => "Testing notion task ",
                "text" => %{"content" => "Testing notion task ", "link" => nil},
                "type" => "text"
              }
            ],
            "type" => "title"
          }
        },
        "public_url" => nil,
        "request_id" => "6ec95592-c7e8-4041-8806-1c176a3a4569",
        "url" => "https://www.notion.so/Testing-notion-task-160673e59ab680c0b090cf8b8b4758e0"
      }

      Req.Test.stub(Notioner, fn conn ->
        Req.Test.json(conn, mock_body)
      end)

      assert Page.get("mock-page-id") == mock_body
    end
  end

  describe "get page property" do
    test "ok" do
      mock_body = %{
        "has_more" => false,
        "next_cursor" => nil,
        "object" => "list",
        "property_item" => %{
          "id" => "title",
          "next_url" => nil,
          "title" => %{},
          "type" => "title"
        },
        "request_id" => "a5c72864-64fb-4074-b01c-362da29b5a0c",
        "results" => [
          %{
            "id" => "title",
            "object" => "property_item",
            "title" => %{
              "annotations" => %{
                "bold" => false,
                "code" => false,
                "color" => "default",
                "italic" => false,
                "strikethrough" => false,
                "underline" => false
              },
              "href" => nil,
              "plain_text" => "Testing notion task ",
              "text" => %{"content" => "Testing notion task ", "link" => nil},
              "type" => "text"
            },
            "type" => "title"
          }
        ],
        "type" => "property_item"
      }

      Req.Test.stub(Notioner, fn conn ->
        Req.Test.json(conn, mock_body)
      end)

      assert Page.get_property("mock-page-id", "title") == mock_body
    end
  end
end
