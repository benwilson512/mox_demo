defmodule MoxDemo do
  alias MoxDemo.IO, as: MyIO

  def main(args) do
    time_unit = :microsecond
    microseconds_before = MyIO.monotonic_time(time_unit)
    target = args |> List.first() |> MyIO.read_file!()
    MyIO.puts("Hello, #{target}!")
    microseconds_after = MyIO.monotonic_time(time_unit)
    microseconds_duration = microseconds_after - microseconds_before
    MyIO.puts("Took #{microseconds_duration} microseconds")
  end
end
