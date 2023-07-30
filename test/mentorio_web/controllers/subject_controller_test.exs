defmodule MentorioWeb.SubjectControllerTest do
  use MentorioWeb.ConnCase

  import Mentorio.StudyFixtures

  @create_attrs %{name: "some name", description: "some description"}
  @update_attrs %{name: "some updated name", description: "some updated description"}
  @invalid_attrs %{name: nil, description: nil}

  describe "index" do
    test "lists all subjects", %{conn: conn} do
      conn = get(conn, ~p"/subjects")
      assert html_response(conn, 200) =~ "Listing Subjects"
    end
  end

  describe "new subject" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/subjects/new")
      assert html_response(conn, 200) =~ "New Subject"
    end
  end

  describe "create subject" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/subjects", subject: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/subjects/#{id}"

      conn = get(conn, ~p"/subjects/#{id}")
      assert html_response(conn, 200) =~ "Subject #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/subjects", subject: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Subject"
    end
  end

  describe "edit subject" do
    setup [:create_subject]

    test "renders form for editing chosen subject", %{conn: conn, subject: subject} do
      conn = get(conn, ~p"/subjects/#{subject}/edit")
      assert html_response(conn, 200) =~ "Edit Subject"
    end
  end

  describe "update subject" do
    setup [:create_subject]

    test "redirects when data is valid", %{conn: conn, subject: subject} do
      conn = put(conn, ~p"/subjects/#{subject}", subject: @update_attrs)
      assert redirected_to(conn) == ~p"/subjects/#{subject}"

      conn = get(conn, ~p"/subjects/#{subject}")
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, subject: subject} do
      conn = put(conn, ~p"/subjects/#{subject}", subject: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Subject"
    end
  end

  describe "delete subject" do
    setup [:create_subject]

    test "deletes chosen subject", %{conn: conn, subject: subject} do
      conn = delete(conn, ~p"/subjects/#{subject}")
      assert redirected_to(conn) == ~p"/subjects"

      assert_error_sent 404, fn ->
        get(conn, ~p"/subjects/#{subject}")
      end
    end
  end

  defp create_subject(_) do
    subject = subject_fixture()
    %{subject: subject}
  end
end
