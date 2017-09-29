class OutboundWebhooksController < ApplicationController
  protect_from_forgery except: [:delivery, :bounce, :opens]
  before_action :set_outbound_webhook_event_request, only: [:show, :destroy]

  # Pagination will be implemented next
  def index
    @title = "Outbound Webhook"
    @outbound_webhook = OutboundWebhook.all
  end

  def show
    @title = "Outbound Webhook Show"
  end

  def destroy
    @outbound_webhook.destroy

    respond_to do |format|
      format.html { redirect_to webhook_event_requests_url }
      format.json { head :no_content }
    end
  end

  def delivery
    request.body.rewind
    @outbound_webhook = OutboundWebhook.new(payload: request.body.read, webhook_type: 'delivery')
    @title = "Outbound Webhook Delivery"

    if @outbound_webhook.save
      render json: @outbound_webhook, status: :created
    else
      render json: @outbound_webhook.errors, status: :unprocessable_entity
    end
  end

  def bounce
    request.body.rewind
    @outbound_webhook = OutboundWebhook.new(payload: request.body.read, webhook_type: 'bounce')
    @title = "Outbound Webhook Bounce"

    if @outbound_webhook.save
      render json: @outbound_webhook, status: :created
    else
      render json: @outbound_webhook.errors, status: :unprocessable_entity
    end
  end

  def opens
    request.body.rewind
    @outbound_webhook = OutboundWebhook.new(payload: request.body.read, webhook_type: 'opens')
    @title = "Outbound Webhook Opens"

    if @outbound_webhook.save
      render json: @outbound_webhook, status: :created
    else
      render json: @outbound_webhook.errors, status: :unprocessable_entity
    end
  end

  def delivery_outbound_messages
    @outbound_webhook = OutboundWebhook.where(webhook_type: 'delivery').all
  end

  def bounce_outbound_messages
    @outbound_webhook = OutboundWebhook.where(webhook_type: 'bounce').all
  end

  def opens_outbound_messages
    @outbound_webhook = OutboundWebhook.where(webhook_type: 'opens').all
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_outbound_webhook_event_request
      @outbound_webhook = OutboundWebhook.find(params[:id])
    end
end
