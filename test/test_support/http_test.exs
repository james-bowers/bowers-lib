defmodule Test.ExBowers.TestSupport.HTTP do
  use ExBowers.TestSupport.HTTP, ExBowers.FakeApp.Router

  describe "http test support helper" do
    test "GET method" do
      assert {200, body, _headers} = get("/")
      assert %{"get_status" => "ok"} = body
    end

    test "POST method" do
      assert {200, body, _headers} = post("/")
      assert %{"post_status" => "ok"} = body
    end
  end
end
