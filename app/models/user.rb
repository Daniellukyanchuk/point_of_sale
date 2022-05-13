class User < ApplicationRecord
  has_many :role_users
  has_many :roles, through: :role_users

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def add_role_users(params)
      role_ids = params["role_users_attributes"]["role_id"].values
              
      role_ids.each do |r_id|
        role_users.push(RoleUser.new(role_id: r_id))
    end
  end
  
  def update_role_users(params)  
      role_ids = params["role_users_attributes"]["role_id"].values

      #find all existing permissions for this role
      roles_to_clear = RoleUser.where("user_id = ?", params[:id].to_i)
      #delete all existing permissions for this role
      RoleUser.destroy(roles_to_clear.ids)
    
      #create role permissions according to new params      
      role_ids.each do |r_id|
          role_users.push(RoleUser.new(role_id: r_id))
      end
  end
end
