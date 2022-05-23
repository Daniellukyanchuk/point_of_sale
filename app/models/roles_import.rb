class RolesImport
	include ActiveModel::Model
	require 'json'

	attr_accessor :file
    
    def self.import(file_name)
    	# Getting the file in the json_hash format
    	json = check_for_json(file_name)
    	# Taking the role_name and assigning it to a variable. 
    	json_uniq = json.uniq { |js| js["role_name"]}

    	json_uniq.each do |role_name|
    		if !Role.exists?(:role_name => role_name["role_name"])
    		  Role.create(role_name: role_name["role_name"])
    		end
    	end

    	set_role_permission = role_per_create(json)
    end

    def self.role_per_create(json)
    	json.each do |role_name|
    		role_id = Role.where("role_name = ?", role_name["role_name"]).first.id
    		permission_id = Permission.where("permissions.table = ? AND permissions.action = ?", role_name["table"], role_name["action"]).first.id
    		RolePermission.create(role_id: role_id, permission_id: permission_id)
    	end    
    end

    def self.check_for_json(file_name)
    	case File.extname(file_name["file"].original_filename)
    	when ".json" then roles_json = File.read(file_name["file"].path)
    	json_hash = JSON.parse(roles_json)
        else raise "Unknown file type: #{original_filename}"
    	end
    end
end