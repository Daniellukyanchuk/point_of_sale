class Role < ApplicationRecord
    has_many :users, through: :role_users
    has_many :role_users
    has_many :role_permissions
    has_many :permissions, through: :role_permissions
    accepts_nested_attributes_for :role_permissions , allow_destroy: true    
   
    def add_role_permissions(params)
        permission_ids = params["role"]["role_permissions_attributes"]["permissions_id"].values
                
        permission_ids.each do |p_id|
            role_permissions.push(RolePermission.new(permission_id: p_id))
        end
    end

    def update_role_permissions(params)     
        permission_ids = params["role"]["role_permissions_attributes"]["permissions_id"].values

        #find all existing permissions for this role
        permissions_to_clear = RolePermission.where("role_id = ?", params[:id].to_i)
        #delete all existing permissions for this role
        RolePermission.destroy(permissions_to_clear.ids)
     
        #create role permissions according to new params      
        permission_ids.each do |p_id|
            role_permissions.push(RolePermission.new(permission_id: p_id))
        end
    end
end


