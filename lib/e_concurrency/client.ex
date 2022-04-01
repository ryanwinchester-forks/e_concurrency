defmodule EConcurrency.Client do
  @moduledoc """
  The HTTP client for sync/async stuff.
  """

  require Logger

  @urls [
    "https://jsonplaceholder.typicode.com/posts",
    "https://jsonplaceholder.typicode.com/comments",
    "https://jsonplaceholder.typicode.com/albums",
    "https://jsonplaceholder.typicode.com/photos",
    "https://jsonplaceholder.typicode.com/todos",
    "https://jsonplaceholder.typicode.com/users",
  ]

  @doc """
  Call the APIs syncronously.
  """
  @spec call_apis_sync() :: [Req.Response.t()]
  def call_apis_sync do
    Logger.debug("[Client] calling APIs sync...")
    Enum.map(@urls, &Req.get!/1)
  end

  @doc """
  Call the APIs asynchronously.
  """
  @spec call_apis_async() :: [{:ok, Req.Response.t()} | {:exit, atom()}]
  def call_apis_async do
    Logger.debug("[Client] calling APIs async...")
    # `Task.async_stream/1` returns a Stream that is lazily-evaluated, so we
    # need to force it to run and turn the result into a list with `Enum` module.
    Task.async_stream(@urls, &Req.get!/1) |> Enum.to_list()
  end

  @doc """
  Return a list of all the URLs that we use.
  """
  @spec list_urls :: [String.t()]
  def list_urls, do: @urls
end
