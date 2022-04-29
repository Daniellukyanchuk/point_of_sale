class User < ApplicationRecord
  has_many :roles, through: :role_users
  has_many :role_users
  accepts_nested_attributes_for :role_users, allow_destroy: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    def create_role_users(role_user_records)
      role_ids = role_user_records[:role][:role_user_attributes][:role_user_id].values

      role_ids.each do |ri|
        role_users.push(RoleUser.new(role_id: ri.to_i))
      end
    end

    def update_role_users(role_user_ids)
       current_roles = RoleUser.where("role_id = ?", role_user_ids[:id].to_i)
       RoleUser.delete(current_roles)
       incoming_values = role_user_ids[:role][:role_user_attributes][:role_user_id].values

      incoming_values.each do |pi|
        role_users.push(RoleUser.new(role_id: pi.to_i))
      end
    end
end
