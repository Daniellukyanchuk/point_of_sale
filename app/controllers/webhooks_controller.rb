require 'net/http'
require 'open-uri'

class WebhooksController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
        stop
        byebug
        payload = request.body.read
        sig_header = request.env['HTTP_STRIPE_SIGNATURE']
        event = nil

        begin
            event = Stripe::Webhook.construct_event(
                payload, sig_header, Rails.application.credentials[Rails.env.to_sym][:stripe][:webhook]
            )
        rescue JSON::ParseError => e
            status 400
            return
        rescue Stripe::SignatureVerificationError => each
            # invalid signature
            puts "Signature error"
            put e
            return
        end

        # handle events
        case event.type
        when 'checkout.session.completed'
            # session = event.data.object
            # @product = Product.find_by...
            
        end

        render json: { message: 'payment successful' }
    end
end