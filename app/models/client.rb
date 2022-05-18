class Client < ApplicationRecord
    has_many :orders
    has_many :order_products, through: :orders
    has_many :products, through: :order_products
    attr_accessor :dob_day, :dob_month, :dob_year
    validates :name, :last_name, :date_of_birth, :phone, :address, :city, :zip_code, presence: true
    
    def self.search(search)
      if !search.blank?
          return Client.where("name ilike ? or address ilike ? or id = ?", "%#{search.strip}%", "%#{search.strip}%", search.to_i)
      else
      Client.all
      end
    end

    def self.compile_date(params)
      date_of_birth = ""
      date_of_birth <<  params[:client][:dob_year].to_s << "-" << params[:client][:dob_month].to_s << "-" << params[:client][:dob_day].to_s
      params[:date_of_birth] = date_of_birth.to_date
      return params
    end

end
