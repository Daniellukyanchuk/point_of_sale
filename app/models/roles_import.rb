require 'json'

class RolesImport 
	include ActiveModel::Model    
	
	attr_accessor :file    

    def self.import(file)
        # check if file is correct format
        json = get_json(file)
        # convert json to objects
        role_objects = JSON.parse(json)
        # get unique role names
        role_names = role_names = role_objects.map { |ro| ro['role_name'] }.uniq
        # check for conflicting role names
        new_role_names = remove_existing_roles(role_names) 
        # save roles to database
        create_roles(new_role_names)
        # save role_permissions to database
        create_role_permissions(role_objects)       
    end

    # TODO this method should receive the file name, open the file and return the json
    def self.get_json(file)
        case File.extname(file["file"].original_filename)
	    when ".json" then file = File.read(file["file"].path)
	    else raise "Unknown file type: #{file.original_filename}"
	    end
    end

    def self.remove_existing_roles(role_names)
    existing_roles = []
        role_names.each do |rn|
            if Role.exists?(['role_name LIKE ?', "%#{rn}%"])
                existing_roles.push(rn)
            end
        end
        new_role_names = role_names - existing_roles
    end    

    def self.create_roles (role_names)
        role_names.each do |role|
            Role.create(:role_name => role)
        end
    end
	
    def self.create_role_permissions (role_objects)
        role_objects.each do |rp|
            role_id = Role.where("role_name LIKE ?", rp["role_name"]).first.id
            permission_id = Permission.where("permissions.table LIKE ? AND permissions.action LIKE ?", rp["table"], rp["action"]).first.id
            RolePermission.create(:role_id => role_id, :permission_id => permission_id)
        end
    end
 end










