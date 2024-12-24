defmodule Notioner.DatabaseTest do
  use ExUnit.Case

  alias Notioner.Database, as: Db

  describe "parse_schema" do
    test "ok" do
      assert Db.parse_schema(Notioner.Test.Data.demo_db_schema()) == %{
               id: "52dea0fc-62ab-477b-a913-f6a32526f96a",
               title: "Tasks",
               url: "https://www.notion.so/52dea0fc62ab477ba913f6a32526f96a",
               properties: [
                 {"Assignee", "people", %{id: "notion%3A%2F%2Ftasks%2Fassign_property"}},
                 {"Checked", "checkbox", %{id: "0935a791-ca68-4901-a3c2-556f24e5ebce"}},
                 {"Completed on", "date", %{id: "%60d%3Bl"}},
                 {"Created time", "created_time", %{id: "%5C%3A~A"}},
                 {"Delay", "formula", %{id: "%5B%3EkY"}},
                 {"Due", "date", %{id: "notion%3A%2F%2Ftasks%2Fdue_date_property"}},
                 {"ID", "unique_id", %{id: "MF~g"}},
                 {"ID-Title", "formula", %{id: "GYYb"}},
                 {"Last edited time", "last_edited_time", %{id: "Ddpb"}},
                 {"Parent-task", "relation",
                  %{id: "notion%3A%2F%2Ftasks%2Fparent_task_relation"}},
                 {"Priority", "select",
                  %{
                    id: "notion%3A%2F%2Ftasks%2Fpriority_property",
                    options: ["Low", "Medium", "High"]
                  }},
                 {"Project", "relation",
                  %{id: "notion%3A%2F%2Ftasks%2Ftask_to_project_relation"}},
                 {"Status", "status",
                  %{
                    id: "notion%3A%2F%2Ftasks%2Fstatus_property",
                    options: ["Will", "Not Started", "In Progress", "Done", "Archived"]
                  }},
                 {"Sub-tasks", "relation", %{id: "notion%3A%2F%2Ftasks%2Fsub_task_relation"}},
                 {"Tags", "multi_select",
                  %{
                    id: "notion%3A%2F%2Ftasks%2Ftags_property",
                    options: ["Improvement", "Research"]
                  }},
                 {"Task name", "title", %{id: "title"}}
               ],
               public_url: nil
             }
    end
  end

  describe "parse_row" do
    test "ok" do
      assert Db.parse_row(Notioner.Test.Data.demo_row_data()) == [
               {"ID__", "163673e5-9ab6-80ac-9112-dfd53923ac86", %{type: "builtin"}},
               {"Assignee", [], %{id: "notion%3A%2F%2Ftasks%2Fassign_property", type: "people"}},
               {"Checked", false,
                %{id: "0935a791-ca68-4901-a3c2-556f24e5ebce", type: "checkbox"}},
               {"Completed on", nil, %{id: "%60d%3Bl", type: "date"}},
               {"Created time", "2024-12-21T01:48:00.000Z",
                %{id: "%5C%3A~A", type: "created_time"}},
               {"Delay", nil, %{id: "%5B%3EkY", type: "formula"}},
               {"Due", nil, %{id: "notion%3A%2F%2Ftasks%2Fdue_date_property", type: "date"}},
               {"ID", %{"number" => 227, "prefix" => nil}, %{id: "MF~g", type: "unique_id"}},
               {"ID-Title", "227-Notioner-db-pretty rows", %{id: "GYYb", type: "formula"}},
               {"Last edited time", "2024-12-21T01:48:00.000Z",
                %{id: "Ddpb", type: "last_edited_time"}},
               {"Parent-task", :not_supported_releation_array,
                %{id: "notion%3A%2F%2Ftasks%2Fparent_task_relation", type: "relation"}},
               {"Priority", nil,
                %{id: "notion%3A%2F%2Ftasks%2Fpriority_property", type: "select"}},
               {"Project", :not_supported_releation_array,
                %{id: "notion%3A%2F%2Ftasks%2Ftask_to_project_relation", type: "relation"}},
               {"Status", "In Progress",
                %{id: "notion%3A%2F%2Ftasks%2Fstatus_property", type: "status"}},
               {"Sub-tasks", :not_supported_releation_array,
                %{id: "notion%3A%2F%2Ftasks%2Fsub_task_relation", type: "relation"}},
               {"Tags", [], %{id: "notion%3A%2F%2Ftasks%2Ftags_property", type: "multi_select"}},
               {"Task name", "Notioner-db-pretty rows", %{id: "title", type: "title"}}
             ]
    end
  end
end
