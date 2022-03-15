class Setting < ApplicationRecord
	has_one_attached :logo, :dependent => :destroy
end
