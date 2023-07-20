import Config

config :mox_demo, io_backend: MoxDemo.IO.Native

if Mix.env() == :test do
  import_config("test.exs")
end
