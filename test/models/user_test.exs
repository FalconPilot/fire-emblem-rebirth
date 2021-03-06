defmodule FerForum.UserTest do
  use FerForum.ModelCase

  alias FerForum.User

  @valid_attrs %{avatar: "some content", charsheet: %{}, email: "some content", password: "some content", privilege: 42, username: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
