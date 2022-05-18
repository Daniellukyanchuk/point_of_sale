class CheckoutController < ApplicationController
	def create
		product = Product.find(params[:id])
        @session = Stripe::Checkout::Session.create({
		  payment_method_types: ['card'],
		  line_items: [{
		  	name: product.product_name,
		  	amount: product.price.to_i , 
		  	currency: "usd",
		  	quantity: 1
		  }],
		  mode: 'payment',
		  success_url: processing_payment_url,
		  cancel_url: processing_payment_url,
		})
		respond_to do |format|
			format.js
		end
	end
end