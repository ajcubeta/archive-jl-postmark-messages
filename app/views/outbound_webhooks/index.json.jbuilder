json.array!(@outbound_webhooks) do |outbound_webhook|
  json.extract! outbound_webhook, :payload, :webhook_type
  json.url outbound_webhook_url(outbound_webhook, format: :json)
end
