class MessageDetail < ApplicationRecord
  def self.query_postmark_outbound_message_details(message_id)
    return nil if message_id.blank?
    message = `curl "https://api.postmarkapp.com/messages/outbound/#{message_id}/details" \
                -X GET -H "Accept: application/json" \
                -H "X-Postmark-Server-Token: #{ENV["POSTMARK_API_KEY"]}"`

    message_to_json = self.parse_message_to_json(message)
  end

  def self.parse_message_to_json(message)
    return {} if message.blank?
    parsed_message = JSON.parse(message)
  end
end
