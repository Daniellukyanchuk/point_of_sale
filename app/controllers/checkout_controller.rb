class CheckoutController < ApplicationController

    def create
        product = Product.find(params[:id])
        @session = Stripe::Checkout::Session.create({
            payment_method_types: ['card'],
            line_items: [
                price_data: {
                product: '{{PRODUCT_ID}}',
                unit_amount: 1500,
                currency: 'usd',
                },
                quantity: 1,
            ],
            mode: 'payment',
            success_url: root_url,
            cancel_url: root_url,
        })
        respond_to do |format|
            format.js
        end
    end

end
