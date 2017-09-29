Rails.application.routes.draw do
  match '/outbound_webhooks/delivery', to: 'outbound_webhooks#delivery_outbound_messages', via: [:get]
  match '/outbound_webhooks/bounce',   to: 'outbound_webhooks#bounce_outbound_messages',   via: [:get]
  match '/outbound_webhooks/opens',    to: 'outbound_webhooks#open_outbound_messages',     via: [:get]

  resources :outbound_webhooks do
    post 'delivery', on: :collection
    post 'bounce', on: :collection
    post 'opens', on: :collection
  end

  root to: "home#index"
end
