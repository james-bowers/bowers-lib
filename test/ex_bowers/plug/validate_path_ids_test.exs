defmodule Test.BowersLib.Plug.ValidatePathIds do
  use BowersLib.TestSupport.HTTP, BowersLib.FakeApp.Router

  describe "validates ecto IDs in path" do
    test "allows valid ecto uuid" do
      assert {200, body, _headers} = get("/resource/65b930d2-38cd-434b-b1b2-156cabf88c63")
    end

    test "rejects invalid ecto uuid" do
      assert {400, body, _headers} = get("/resource/foo")
    end
  end
end
