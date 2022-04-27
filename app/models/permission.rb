class Permission < ApplicationRecord
    has_many :role_permissions
    has_many :roles, through: :role_permissions
    
    def self.get_new_permissions
        sql =     
             """
                SELECT tablename
                FROM pg_catalog.pg_tables
                WHERE   schemaname != 'pg_catalog' AND 
                        schemaname != 'information_schema' AND
                        tablename NOT IN ('schema_migrations', 'ar_internal_metadata');
             """
        results = ActiveRecord::Base.connection.execute(sql)
        results = results.values.flatten 

        def self.remove_existing(tablenames)
            tablenames.each do |p|      
                if Permission.exists?(:table => p)
                    tablenames.delete(p)
                    self.remove_existing(tablenames)                
                end           
            end 
        end
    
        new_permissions = self.remove_existing(results)
    
        permissions_to_add = []    
        new_permissions.each do |p|
            permission_row = []
            permission_row.push([p, "read"])
            permission_row.push([p, "write"])
            permission_row.push([p, "destroy"])
            permission_row.push([p, "all"])
            permissions_to_add.push(permission_row)
        end
        return permissions_to_add            
    end         
end

