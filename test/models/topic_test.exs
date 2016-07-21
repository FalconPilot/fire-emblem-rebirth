defmodule FerForum.TopicTest do
  use FerForum.ModelCase

  alias FerForum.Topic

  @valid_attrs %{messages: [], name: "some content", subtopics: []}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Topic.changeset(%Topic{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Topic.changeset(%Topic{}, @invalid_attrs)
    refute changeset.valid?
  end
end
