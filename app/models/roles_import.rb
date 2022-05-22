require 'json'

class RolesImport 
	include ActiveModel::Model    
	
	attr_accessor :file    


	def initialize(attributes={})
		attributes.each { |name, value| send("#{name}=", value) }
	end

	def persisted?
		false
	end

	def open_json_file
		case File.extname(file.original_filename)
	    when ".json" then file = File.read(file.path)
	    else raise "Unknown file type: #{file.original_filename}"
	    end
    end

    def import_roles
	    json_data = File.read(file.path)
        hash_from_json = JSON.parse(json_data)
        role_names = hash_from_json.map { |rn| rn['role_name'] }.uniq
            # remove all role names already existing in the database
            existing_roles = []
            role_names.each do |rn|
                if Role.exists?(['role_name LIKE ?', "%#{rn}%"])
                    existing_roles.push(rn)
                end
            end

        role_names = role_names - existing_roles
            # add Roles to roles table    
        role_names.each do |role|
            Role.create(:role_name => role)
        end

        hash_from_json.each do |rp|
            role_id = Role.where("role_name LIKE ?", rp.role_name)
            permission_id = Permission.where("permissions.table LIKE ? AND permissions.action LIKE ?", rp.table, rp.action)
            RolePermission.create(:role_id => role_id, :permission_id => permission_id)
        end
    end
 end
