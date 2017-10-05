class OutboundMessagesController < ApplicationController
  before_action :authenticate

  def index
    @title= "Outbound Messages"
    @messages = OutboundMessage.paginate(:page => params[:page], :per_page => 30)
  end
end
