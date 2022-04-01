defmodule EConcurrency.ClientTest do
  @moduledoc """
  We're mocking `Req.get!/1` with `Mimic` up in here.
  """
  use ExUnit.Case, async: true
  use Mimic

  alias EConcurrency.Client

  test "call_apis_sync/0 does the stuff" do
    urls = Client.list_urls()

    Req
    |> expect(:get!, fn url ->
      assert url == Enum.at(urls, 0)
      %Req.Response{body: ["thing"]}
    end)
    |> expect(:get!, fn url ->
      assert url == Enum.at(urls, 1)
      %Req.Response{body: ["thing"]}
    end)
    |> expect(:get!, fn url ->
      assert url == Enum.at(urls, 2)
      %Req.Response{body: ["thing"]}
    end)
    |> expect(:get!, fn url ->
      assert url == Enum.at(urls, 3)
      %Req.Response{body: ["thing"]}
    end)
    |> expect(:get!, fn url ->
      assert url == Enum.at(urls, 4)
      %Req.Response{body: ["thing"]}
    end)
    |> expect(:get!, fn url ->
      assert url == Enum.at(urls, 5)
      %Req.Response{body: ["thing"]}
    end)

    assert resp = Client.call_apis_sync()
    assert length(resp) == 6
  end

  test "call_apis_async/0 does the stuff" do
    urls = Client.list_urls()

    Req
    |> expect(:get!, fn url ->
      assert url == Enum.at(urls, 0)
      %Req.Response{body: ["thing"]}
    end)
    |> expect(:get!, fn url ->
      assert url == Enum.at(urls, 1)
      %Req.Response{body: ["thing"]}
    end)
    |> expect(:get!, fn url ->
      assert url == Enum.at(urls, 2)
      %Req.Response{body: ["thing"]}
    end)
    |> expect(:get!, fn url ->
      assert url == Enum.at(urls, 3)
      %Req.Response{body: ["thing"]}
    end)
    |> expect(:get!, fn url ->
      assert url == Enum.at(urls, 4)
      %Req.Response{body: ["thing"]}
    end)
    |> expect(:get!, fn url ->
      assert url == Enum.at(urls, 5)
      %Req.Response{body: ["thing"]}
    end)

    assert resp = Client.call_apis_async()
    assert Enum.count(resp) == 6
  end
end
