defmodule InteractiveTest do
  use ExUnit.Case, async: true

  import Mox

  setup :verify_on_exit!

  setup do
    test_pid = self()

    MoxDemo.IO.Mock
    |> stub(:monotonic_time, fn unit ->
      send(test_pid, {:monotonic_time, unit})

      receive do
        {:monotonic_time, n} -> n
      end
    end)
    |> stub(:read_file!, fn path ->
      send(test_pid, {:read_file!, path})

      receive do
        {:file_contents, contents} -> contents
      end
    end)
    |> stub(:puts, fn text ->
      send(test_pid, {:puts, text})
    end)

    :ok
  end

  test "we can chat with main" do
    {:ok, pid} = Task.start_link(fn -> MoxDemo.main(["path/to/file"]) end)

    assert_receive {:monotonic_time, :microsecond}
    send(pid, {:monotonic_time, 100})

    assert_receive {:read_file!, "path/to/file"}
    send(pid, {:file_contents, "the file contents"})

    assert_receive {:puts, "Hello, the file contents!"}

    assert_receive {:monotonic_time, :microsecond}
    send(pid, {:monotonic_time, 137})

    assert_receive({:puts, "Took 37 microseconds"})

    # and we didn't get anything extra
    refute_receive _
  end
end
