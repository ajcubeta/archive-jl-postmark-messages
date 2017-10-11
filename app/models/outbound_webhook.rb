class OutboundWebhook < ApplicationRecord
  def migrated!
    update_attributes(migrate: 'yes')
  end
end
