class WebhooksController < ApplicationController
    skip_before_action :verify_authenticity_token
    skip_before_action :authenticate_user!, :only => [:create]

    def create
        payload = request.body.read
        sig_header = request.env['HTTP_STRIPE_SIGNATURE']
        event = nil

        begin
            event = Stripe::Webhook.construct_event(
                payload, sig_header, Rails.application.credentials[:stripe][:webhook]
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
            # @product = Product.
            
        end

        render json: { message: 'payment successful' }
        flash["success"] = _("payment successful")
    end
end