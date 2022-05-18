class TestsController < ApplicationController
	skip_before_action :authenticate_user!
	
	def index

		# ab = Ability.new(current_user)
fdss

		# orders = Order.where("CAST(created_at as date) = ? AND grand_total => ?", Date.today - 1.day, 5000)
		# orders.each do |o|
		# 	o.order_products.each do |oop|

		# 	end	
		# end

		# order_product_id 112 clients_id should be 9 not ten

		orders = Order.search("", "", "", "")

		o = Order.find(100)
		o.client_id = 9
		o.save


		order.update(client_id: 9)

		op = OrderProduct.where(id: 112).first
		order_product = OrderProduct.find(112)
		 
		op.order.client_id = 9
		op.order.save

		# order_product.order.update(client_id: 9)
		  
		# ActiveRecord::Base.connection.execute(“update orders set client_id = 9 where id = (select order_id from order_products where id = 112)”)
        
	end
end