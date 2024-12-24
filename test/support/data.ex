defmodule Notioner.Test.Data do
  def demo_db_schema do
    %{
      "archived" => false,
      "cover" => nil,
      "created_by" => %{
        "id" => "a1a07517-b528-439d-91d0-50a809b1a23f",
        "object" => "user"
      },
      "created_time" => "2024-08-23T06:42:00.000Z",
      "description" => [
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
          "plain_text" => "Do great jobs step by step!",
          "text" => %{"content" => "Do great jobs step by step!", "link" => nil},
          "type" => "text"
        }
      ],
      "icon" => %{
        "external" => %{"url" => "/images/app-packages/task-db-icon.svg"},
        "type" => "external"
      },
      "id" => "52dea0fc-62ab-477b-a913-f6a32526f96a",
      "in_trash" => false,
      "is_inline" => false,
      "last_edited_by" => %{
        "id" => "a1a07517-b528-439d-91d0-50a809b1a23f",
        "object" => "user"
      },
      "last_edited_time" => "2024-12-21T02:01:00.000Z",
      "object" => "database",
      "parent" => %{
        "page_id" => "191be204-65e8-4bd7-992b-d00a36565967",
        "type" => "page_id"
      },
      "properties" => %{
        "Assignee" => %{
          "id" => "notion%3A%2F%2Ftasks%2Fassign_property",
          "name" => "Assignee",
          "people" => %{},
          "type" => "people"
        },
        "Checked" => %{
          "checkbox" => %{},
          "id" => "0935a791-ca68-4901-a3c2-556f24e5ebce",
          "name" => "Checked",
          "type" => "checkbox"
        },
        "Completed on" => %{
          "date" => %{},
          "id" => "%60d%3Bl",
          "name" => "Completed on",
          "type" => "date"
        },
        "Created time" => %{
          "created_time" => %{},
          "id" => "%5C%3A~A",
          "name" => "Created time",
          "type" => "created_time"
        },
        "Delay" => %{
          "formula" => %{
            "expression" =>
              "dateBetween({{notion:block_property:%60d%3Bl:00000000-0000-0000-0000-000000000000:fb8b145d-c3ba-4ab7-bd75-80832c1198f6}}, {{notion:block_property:notion%3A%2F%2Ftasks%2Fdue_date_property:00000000-0000-0000-0000-000000000000:fb8b145d-c3ba-4ab7-bd75-80832c1198f6}}, \"days\")"
          },
          "id" => "%5B%3EkY",
          "name" => "Delay",
          "type" => "formula"
        },
        "Due" => %{
          "date" => %{},
          "id" => "notion%3A%2F%2Ftasks%2Fdue_date_property",
          "name" => "Due",
          "type" => "date"
        },
        "ID" => %{
          "id" => "MF~g",
          "name" => "ID",
          "type" => "unique_id",
          "unique_id" => %{"prefix" => nil}
        },
        "ID-Title" => %{
          "formula" => %{
            "expression" =>
              "join([{{notion:block_property:MF~g:00000000-0000-0000-0000-000000000000:fb8b145d-c3ba-4ab7-bd75-80832c1198f6}},{{notion:block_property:title:00000000-0000-0000-0000-000000000000:fb8b145d-c3ba-4ab7-bd75-80832c1198f6}}], \"-\")"
          },
          "id" => "GYYb",
          "name" => "ID-Title",
          "type" => "formula"
        },
        "Last edited time" => %{
          "id" => "Ddpb",
          "last_edited_time" => %{},
          "name" => "Last edited time",
          "type" => "last_edited_time"
        },
        "Parent-task" => %{
          "id" => "notion%3A%2F%2Ftasks%2Fparent_task_relation",
          "name" => "Parent-task",
          "relation" => %{
            "database_id" => "52dea0fc-62ab-477b-a913-f6a32526f96a",
            "dual_property" => %{
              "synced_property_id" => "notion%3A%2F%2Ftasks%2Fsub_task_relation",
              "synced_property_name" => "Sub-tasks"
            },
            "type" => "dual_property"
          },
          "type" => "relation"
        },
        "Priority" => %{
          "id" => "notion%3A%2F%2Ftasks%2Fpriority_property",
          "name" => "Priority",
          "select" => %{
            "options" => [
              %{
                "color" => "green",
                "description" => nil,
                "id" => "priority_low",
                "name" => "Low"
              },
              %{
                "color" => "yellow",
                "description" => nil,
                "id" => "priority_medium",
                "name" => "Medium"
              },
              %{
                "color" => "red",
                "description" => nil,
                "id" => "priority_high",
                "name" => "High"
              }
            ]
          },
          "type" => "select"
        },
        "Project" => %{
          "id" => "notion%3A%2F%2Ftasks%2Ftask_to_project_relation",
          "name" => "Project",
          "relation" => %{
            "database_id" => "fd0d6c70-54d7-462a-ac95-5d25a9c0af7b",
            "dual_property" => %{
              "synced_property_id" => "notion%3A%2F%2Fprojects%2Fproject_to_task_relation",
              "synced_property_name" => "Tasks"
            },
            "type" => "dual_property"
          },
          "type" => "relation"
        },
        "Status" => %{
          "id" => "notion%3A%2F%2Ftasks%2Fstatus_property",
          "name" => "Status",
          "status" => %{
            "groups" => [
              %{
                "color" => "gray",
                "id" => "todo-status-group",
                "name" => "To-do",
                "option_ids" => ["y_Wy", "not-started"]
              },
              %{
                "color" => "blue",
                "id" => "in-progress-status-group",
                "name" => "In Progress",
                "option_ids" => ["in-progress"]
              },
              %{
                "color" => "green",
                "id" => "complete-status-group",
                "name" => "Complete",
                "option_ids" => ["done", "archived"]
              }
            ],
            "options" => [
              %{
                "color" => "yellow",
                "description" => nil,
                "id" => "y_Wy",
                "name" => "Will"
              },
              %{
                "color" => "default",
                "description" => nil,
                "id" => "not-started",
                "name" => "Not Started"
              },
              %{
                "color" => "blue",
                "description" => nil,
                "id" => "in-progress",
                "name" => "In Progress"
              },
              %{
                "color" => "green",
                "description" => nil,
                "id" => "done",
                "name" => "Done"
              },
              %{
                "color" => "gray",
                "description" => nil,
                "id" => "archived",
                "name" => "Archived"
              }
            ]
          },
          "type" => "status"
        },
        "Sub-tasks" => %{
          "id" => "notion%3A%2F%2Ftasks%2Fsub_task_relation",
          "name" => "Sub-tasks",
          "relation" => %{
            "database_id" => "52dea0fc-62ab-477b-a913-f6a32526f96a",
            "dual_property" => %{
              "synced_property_id" => "notion%3A%2F%2Ftasks%2Fparent_task_relation",
              "synced_property_name" => "Parent-task"
            },
            "type" => "dual_property"
          },
          "type" => "relation"
        },
        "Tags" => %{
          "id" => "notion%3A%2F%2Ftasks%2Ftags_property",
          "multi_select" => %{
            "options" => [
              %{
                "color" => "pink",
                "description" => nil,
                "id" => "Improvement",
                "name" => "Improvement"
              },
              %{
                "color" => "gray",
                "description" => nil,
                "id" => "5188b5dd-60dc-4995-a488-e3418c63af51",
                "name" => "Research"
              }
            ]
          },
          "name" => "Tags",
          "type" => "multi_select"
        },
        "Task name" => %{
          "id" => "title",
          "name" => "Task name",
          "title" => %{},
          "type" => "title"
        }
      },
      "public_url" => nil,
      "request_id" => "efdb8f1e-dc4b-4b39-9316-59c1c744504e",
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
          "plain_text" => "Tasks",
          "text" => %{"content" => "Tasks", "link" => nil},
          "type" => "text"
        }
      ],
      "url" => "https://www.notion.so/52dea0fc62ab477ba913f6a32526f96a"
    }
  end

  def demo_row_data() do
    %{
      "archived" => false,
      "cover" => nil,
      "created_by" => %{
        "id" => "a1a07517-b528-439d-91d0-50a809b1a23f",
        "object" => "user"
      },
      "created_time" => "2024-12-21T01:48:00.000Z",
      "icon" => %{
        "external" => %{
          "url" => "https://www.notion.so/icons/clipping_lightgray.svg"
        },
        "type" => "external"
      },
      "id" => "163673e5-9ab6-80ac-9112-dfd53923ac86",
      "in_trash" => false,
      "last_edited_by" => %{
        "id" => "a1a07517-b528-439d-91d0-50a809b1a23f",
        "object" => "user"
      },
      "last_edited_time" => "2024-12-21T01:48:00.000Z",
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
          "created_time" => "2024-12-21T01:48:00.000Z",
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
          "unique_id" => %{"number" => 227, "prefix" => nil}
        },
        "ID-Title" => %{
          "formula" => %{
            "string" => "227-Notioner-db-pretty rows",
            "type" => "string"
          },
          "id" => "GYYb",
          "type" => "formula"
        },
        "Last edited time" => %{
          "id" => "Ddpb",
          "last_edited_time" => "2024-12-21T01:48:00.000Z",
          "type" => "last_edited_time"
        },
        "Parent-task" => %{
          "has_more" => false,
          "id" => "notion%3A%2F%2Ftasks%2Fparent_task_relation",
          "relation" => [],
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
          "relation" => [%{"id" => "06a51c22-7edc-4543-a10a-0d601cff9f71"}],
          "type" => "relation"
        },
        "Status" => %{
          "id" => "notion%3A%2F%2Ftasks%2Fstatus_property",
          "status" => %{
            "color" => "blue",
            "id" => "in-progress",
            "name" => "In Progress"
          },
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
              "plain_text" => "Notioner-db-pretty rows",
              "text" => %{"content" => "Notioner-db-pretty rows", "link" => nil},
              "type" => "text"
            }
          ],
          "type" => "title"
        }
      },
      "public_url" => nil,
      "url" => "https://www.notion.so/Notioner-db-pretty-rows-163673e59ab680ac9112dfd53923ac86"
    }
  end
end
