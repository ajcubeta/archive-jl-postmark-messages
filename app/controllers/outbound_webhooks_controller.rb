class OutboundWebhooksController < ApplicationController
  protect_from_forgery except: [:delivery, :bounce, :opens]
  before_action :authenticate
  before_action :set_outbound_webhook_event_request, only: [:show, :destroy]

  # Pagination will be implemented next
  def index
    @title = "Outbound Webhooks"
    @webhooks = OutboundWebhook.paginate(:page => params[:page], :per_page => 20)
  end

  def show
    @title = "Outbound Webhook Show"
  end

  def destroy
    @webhook.destroy

    respond_to do |format|
      format.html { redirect_to outbound_webhooks_url }
      format.json { head :no_content }
    end
  end

  def delivery
    request.body.rewind
    @webhook = OutboundWebhook.new(payload: request.body.read, webhook_type: 'delivery')

    if @webhook.save
      render json: @webhook, status: :created
    else
      render json: @webhook.errors, status: :unprocessable_entity
    end
  end

  def bounce
    request.body.rewind
    @webhook = OutboundWebhook.new(payload: request.body.read, webhook_type: 'bounce')

    if @webhook.save
      render json: @webhook, status: :created
    else
      render json: @webhook.errors, status: :unprocessable_entity
    end
  end

  def opens
    request.body.rewind
    @webhook = OutboundWebhook.new(payload: request.body.read, webhook_type: 'opens')


    if @webhook.save
      render json: @webhook, status: :created
    else
      render json: @webhook.errors, status: :unprocessable_entity
    end
  end

  def delivery_outbound_messages
    @title = "Outbound Webhooks - Delivery"
    @webhooks = OutboundWebhook.where(webhook_type: 'delivery').all
  end

  def bounce_outbound_messages
    @title = "Outbound Webhooks - Bounce"
    @webhooks = OutboundWebhook.where(webhook_type: 'bounce').all
  end

  def opens_outbound_messages
    @title = "Outbound Webhooks - Opens"
    @webhooks = OutboundWebhook.where(webhook_type: 'opens').all
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_outbound_webhook_event_request
      @webhook = OutboundWebhook.find(params[:id])
    end
end
