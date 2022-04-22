class Role < ApplicationRecord
	has_many :users, through: :role_user 
	has_many :role_users
	has_many :permissions, through: :role_permissions
	has_many :role_permissions
	accepts_nested_attributes_for :role_permissions, allow_destroy: true
	
end
