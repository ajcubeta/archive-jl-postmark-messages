class MessageDetail < ApplicationRecord
  def self.import_outbound_message_detail(msg)
    msg_detail = MessageDetail.where(message_id: msg.message_id).take

    unless msg_detail
      detail = query_postmark_outbound_message_details(msg.message_id)

      begin
        message_detail = MessageDetail.new
        message_detail.text_body = detail["TextBody"] rescue ''
        message_detail.html_body = detail["HtmlBody"] rescue ''
        message_detail.tag = detail["Tag"] rescue ''
        message_detail.message_id = detail["MessageID"] rescue ''
        message_detail.to = detail["To"] rescue []
        message_detail.cc = detail["Cc"] rescue []
        message_detail.bcc = detail["Bcc"] rescue []
        message_detail.recipients = detail["Recipients"] rescue []
        message_detail.received_at = detail["ReceivedAt"] rescue nil
        message_detail.from = detail["From"] rescue ''
        message_detail.subject = detail["Subject"] rescue ''
        message_detail.attachments = detail["Attachments"] rescue []
        message_detail.status = detail["Status"] rescue ''
        message_detail.track_opens = detail["TrackOpens"] rescue nil
        message_detail.track_links = detail["TrackLinks"] rescue ''
        message_detail.message_events = detail["MessageEvents"] rescue []

        if message_detail.save
          puts "Imported details of MessageID : #{message_detail.message_id}"
        end
      rescue Exception => e
        puts "#{e.message} \n\n #{e.backtrace.inspect}"
        ErrorMailer.notify_sysadmin('Importing outbound message details from postmark has error', e.message, e.backtrace).deliver
      end
    end
  end

  def open_tracking
    track_opens == true ? 'Enabled' : 'Disabled'
  end

  def link_tracking
    case track_links
    when 'HtmlAndText'
      'Enabled for HTML and Text'
    else
      'Disabled for HTML and Text'
    end
  end

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
