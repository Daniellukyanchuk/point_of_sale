class Client < ApplicationRecord
    has_many :orders
    has_many :order_products, through: :orders
    has_many :products, through: :order_products

    def self.search(search)
      if !search.blank?
          return Client.where("name ilike ? or address ilike ? or id = ?", "%#{search.strip}%", "%#{search.strip}%", search.to_i)
      else
      Client.all
      end
    end

end
