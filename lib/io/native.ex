defmodule MoxDemo.IO.Native do
  @behaviour MoxDemo.IO

  def monotonic_time(unit) do
    System.monotonic_time(unit)
  end

  def puts(arg) do
    IO.puts(arg)
  end

  def read_file!(path) do
    File.read!(path)
  end
end
