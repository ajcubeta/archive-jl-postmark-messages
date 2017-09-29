class OutboundMessagesController < ApplicationController
  def index
    @messages = OutboundMessage.all
  end
end
