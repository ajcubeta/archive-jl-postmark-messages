class CreateOutboundWebhooks < ActiveRecord::Migration[5.1]
  def change
    create_table :outbound_webhooks do |t|
      t.jsonb :payload
      t.text  :webhook_type

      t.timestamps
    end
  end
end
