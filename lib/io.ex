defmodule MoxDemo.IO do
  @moduledoc """
  This module represents the IO needs of this system.

  We are grouping all IO needs from time, to file reading in one
  behaviour to keep this simple. You would probably break them up
  in a real application.
  """

  @callback monotonic_time(atom) :: non_neg_integer()
  @callback puts(iodata()) :: :ok
  @callback read_file!(binary) :: binary

  # This is a personal choice, but I tend to prefer making
  # this a compile time value. This provides the best
  # dev experience because backend is a concrete module that
  # gets compiler checked and auto completion.
  @backend Application.compile_env!(:mox_demo, :io_backend)

  def monotonic_time(unit) do
    @backend.monotonic_time(unit)
  end

  def puts(arg) do
    @backend.puts(arg)
  end

  def read_file!(path) do
    @backend.read_file!(path)
  end
end
