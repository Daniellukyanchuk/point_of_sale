class Role < ApplicationRecord
	has_many :role_users
	has_many :users, through: :role_user 
	has_many :role_permissions
	has_many :permissions, through: :role_permissions
	accepts_nested_attributes_for :role_permissions, allow_destroy: true
	
    def self.get_permissions
	  sql = """ 
		SELECT tablename
	    FROM pg_catalog.pg_tables
		WHERE schemaname != 'pg_catalog' 
		AND schemaname != 'information_schema' AND tablename 
		NOT IN ('schema_migrations', 'ar_internal_metadata', 'active_storage_attachments', 'active_storage_blobs');
	  """
	  tables = ActiveRecord::Base.connection.execute(sql)

	  tables = tables.values.flatten
	
	  def self.remove_existing(tables)
		tables.each do |t|
		  if Permission.exists?(:table => t)
			tables.delete(t)
			self.remove_existing(tables)
		  end
		end
	  end

	  new_tables = self.remove_existing(tables)

      permissions = []
      new_tables.each do |et|
      	permissions.push([et, 'read'])
      	permissions.push([et, 'create'])
      	permissions.push([et, 'update'])
      	permissions.push([et, 'destroy'])
      	permissions.push([et, 'manage'])
      end
      return permissions
	end

	def self.organize_permissions
        permissions = Permission.all

        read_action = []
        create_action = []
        update_action = []
        destroy_action = []
        manage_action = []
        table_name = []

        permissions.each do |per|
        	if per.action == "read"
        		read_action.push(per.id)
        		table_name.push(per.table)
            elsif per.action == "create"
            	create_action.push(per.id)
            elsif per.action == "update"
            	update_action.push(per.id)
            elsif per.action == "destroy"
            	destroy_action.push(per.id)
            else per.action == "manage"
            	manage_action.push(per.id)
            end
        end
        sorted_permissions = [read_action, create_action, update_action, destroy_action, manage_action, table_name].transpose
	end

	def create_permissions(permission_ids)
		permissions_v = permission_ids[:role][:role_permissions_attributes][:permissions_id].values

		permissions_v.each do |pi|
		   role_permissions.push(RolePermission.new(permission_id: pi))
        end
	end

	def update_permissions(params_ids)
	   current_permissions = RolePermission.where("role_id = ?", params_ids[:id].to_i)
       RolePermission.delete(current_permissions)
	   incoming_values = params_ids[:role][:role_permissions_attributes][:permissions_id].values

	   incoming_values.each do |pi|
		  role_permissions.push(RolePermission.new(permission_id: pi))
       end
	end

	def self.get_roles_permissions
		sql = """
		        SELECT role_name, permissions.table, permissions.action FROM roles
				JOIN role_permissions ON roles.id=role_permissions.role_id
				JOIN permissions ON role_permissions.permission_id=permissions.id

			  """
        result = ActiveRecord::Base.connection.execute(sql)
	end
end
