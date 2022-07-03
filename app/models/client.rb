class Client < ApplicationRecord
    has_many :orders
    has_many :order_products, through: :orders
    has_many :products, through: :order_products
    validates :name, :last_name, :phone, :address, :city, :zip_code, :dob_day, :dob_month, :dob_year, presence: true
    
    
    def self.search(search)
      if !search.blank?
          return Client.where("name ilike ? or address ilike ? or id = ?", "%#{search.strip}%", "%#{search.strip}%", search.to_i)
      else
      Client.all
      end
    end

    def self.compile_date(params)
      if params["client"] == nil
        params["client"] = params 
      end
      date_of_birth = ""
      date_of_birth <<  params[:client][:dob_year].to_s << "-" << params[:client][:dob_month].to_s << "-" << params[:client][:dob_day].to_s
      params[:client][:date_of_birth] = date_of_birth
      return params
    end

    def signup
      stop
    end

end
