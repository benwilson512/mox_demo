defmodule MoxDemoTest do
  use ExUnit.Case, async: true

  import Mox

  setup :verify_on_exit!

  test "We can mock the world" do
    MoxDemo.IO.Mock
    |> expect(:monotonic_time, 1, fn _unit -> 100 end)
    |> expect(:read_file!, 1, fn _path ->
      # you could assert on the path condition on the path
      "the file contents"
    end)
    |> expect(:puts, 1, fn string ->
      assert string == "Hello, the file contents!"
      :ok
    end)
    |> expect(:monotonic_time, 1, fn _unit -> 137 end)
    |> expect(:puts, 1, fn string ->
      assert string == "Took 37 microseconds"
      :ok
    end)

    MoxDemo.main(["path/to/file"])
  end
end
