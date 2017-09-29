class OutboundWebhook < ApplicationRecord
  validates_presence_of :payload
end
