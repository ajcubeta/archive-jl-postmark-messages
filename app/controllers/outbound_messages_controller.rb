class OutboundMessagesController < ApplicationController
  before_action :authenticate

  def index
    @title= "Outbound Messages"
    @messages = OutboundMessage.paginate(:page => params[:page], :per_page => 30).all

  end

  def show
    @title= "Outbound Message Details"
    @message = MessageDetail.where(message_id: params[:id]).take
  end
end
