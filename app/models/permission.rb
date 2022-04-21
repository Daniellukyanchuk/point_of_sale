class Permission < ApplicationRecord
  belongs_to :role, through: :role_permission 


end