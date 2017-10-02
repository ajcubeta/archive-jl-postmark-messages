class OutboundMessagesController < ApplicationController
  before_action :authenticate

  def index
    @title= "Outbound Messages"
    @messages = OutboundMessage.all
  end
end
