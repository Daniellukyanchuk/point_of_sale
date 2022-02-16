class Client < ApplicationRecord
  has_many :orders
  has_many :products, through: :order_products
  has_many :order_products, through: :orders
  def self.search(search)
    if !search.blank?
      return Client.where("name ilike ? or address like ? or id = ?", "%#{search.strip}%", "%#{search.strip}%", search.to_i)    
    else
      Client.all
    end
  end

  stop
end