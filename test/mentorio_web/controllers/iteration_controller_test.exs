defmodule MentorioWeb.IterationControllerTest do
  use MentorioWeb.ConnCase

  import Mentorio.StudyFixtures

  @create_attrs %{
    name: "some name",
    theme: "some theme",
    purpose: "some purpose",
    notes: "some notes",
    start_date: ~D[2023-07-29],
    end_date: ~D[2023-07-29]
  }
  @update_attrs %{
    name: "some updated name",
    theme: "some updated theme",
    purpose: "some updated purpose",
    notes: "some updated notes",
    start_date: ~D[2023-07-30],
    end_date: ~D[2023-07-30]
  }
  @invalid_attrs %{
    name: nil,
    theme: nil,
    purpose: nil,
    notes: nil,
    start_date: nil,
    end_date: nil
  }

  describe "index" do
    test "lists all iterations", %{conn: conn} do
      conn = get(conn, ~p"/iterations")
      assert html_response(conn, 200) =~ "Listing Iterations"
    end
  end

  describe "new iteration" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/iterations/new")
      assert html_response(conn, 200) =~ "New Iteration"
    end
  end

  describe "create iteration" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/iterations", iteration: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/iterations/#{id}"

      conn = get(conn, ~p"/iterations/#{id}")
      assert html_response(conn, 200) =~ "Iteration #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/iterations", iteration: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Iteration"
    end
  end

  describe "edit iteration" do
    setup [:create_iteration]

    test "renders form for editing chosen iteration", %{conn: conn, iteration: iteration} do
      conn = get(conn, ~p"/iterations/#{iteration}/edit")
      assert html_response(conn, 200) =~ "Edit Iteration"
    end
  end

  describe "update iteration" do
    setup [:create_iteration]

    test "redirects when data is valid", %{conn: conn, iteration: iteration} do
      conn = put(conn, ~p"/iterations/#{iteration}", iteration: @update_attrs)
      assert redirected_to(conn) == ~p"/iterations/#{iteration}"

      conn = get(conn, ~p"/iterations/#{iteration}")
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, iteration: iteration} do
      conn = put(conn, ~p"/iterations/#{iteration}", iteration: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Iteration"
    end
  end

  describe "delete iteration" do
    setup [:create_iteration]

    test "deletes chosen iteration", %{conn: conn, iteration: iteration} do
      conn = delete(conn, ~p"/iterations/#{iteration}")
      assert redirected_to(conn) == ~p"/iterations"

      assert_error_sent 404, fn ->
        get(conn, ~p"/iterations/#{iteration}")
      end
    end
  end

  defp create_iteration(_) do
    iteration = iteration_fixture()
    %{iteration: iteration}
  end
end
