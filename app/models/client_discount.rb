class ClientDiscount < ApplicationRecord
before_create :set_remaining_amount
before_validation :parse_dates

    def parse_dates
        stop
        if !start_date.blank?
        self.start_date =  Date.strptime(self.start_date.to_s, "%Y-%d-%m")
        end
        if !end_date.blank?
        self.end_date =  Date.strptime(self.end_date.to_s, "%Y-%d-%m")
        end
    end

    def set_remaining_amount
        self.discounted_units_left = self.discounted_units
    end
    
end
