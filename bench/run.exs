alias EConcurrency.Client

Logger.configure(level: :warn)

Benchee.run(%{
  "call_apis_sync" => fn -> Client.call_apis_async() end,
  "call_apis_async" => fn -> Client.call_apis_async() end
})
