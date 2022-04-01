defmodule EConcurrency do
  @moduledoc """
  Testing concurrency vs sync stuff in Elixir.

  For timing we will use Erlang's [`:timer.tc/3`][tcdocs] function.

  [tcdocs]: https://www.erlang.org/doc/man/timer.html#tc-3
  """

  @behaviour Plug

  import Plug.Conn

  alias EConcurrency.Client
  alias Plug.Conn

  @doc """
  Plug init is for tinkering with options.
  """
  @impl Plug
  def init(opts), do: opts

  @doc """
  Call the Plug. Instead of using a router, we'll just pattern-match on the path.
  """
  @impl Plug
  # This one will match on the /sync path.
  def call(%Conn{path_info: ["sync"]} = conn, _opts) do
    {runtime_usec, out_list} = :timer.tc(Client, :call_apis_sync, [])

    for o <- out_list do
      IO.puts("Item count #{length(o.body)}")
    end

    runtime_ms = runtime_usec / 1000

    send_resp(conn, 200, "Sync runtime #{runtime_ms} ms")
  end

  # This one will match on the /async path.
  def call(%Conn{path_info: ["async"]} = conn, _opts) do
    {runtime_usec, out_stream} = :timer.tc(Client, :call_apis_async, [])

    Enum.map(out_stream, fn {:ok, o} ->
      IO.puts("Item count #{length(o.body)}")
    end)

    runtime_ms = runtime_usec / 1000

    send_resp(conn, 200, "Async runtime #{runtime_ms} ms")
  end

  # This is the catch-all match. So, it's a 404.
  def call(conn, _opts) do
    IO.inspect(conn, limit: :infinity)
    send_resp(conn, 404, "Not found!")
  end
end
