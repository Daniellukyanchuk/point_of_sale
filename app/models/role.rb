class Role < ApplicationRecord
	belongs_to :user, through: :role_user 
	has_many :role_users
end
