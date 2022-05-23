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
                        tablename NOT IN ('schema_migrations', 'ar_internal_metadata', 'active_storage_blobs', 'active_storage_attachments', 'category_products', 'order_products', 'purchase_products', 'recipe_products');
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
            permission_row.push([p, "create"])
            permission_row.push([p, "update"])
            permission_row.push([p, "destroy"])
            permission_row.push([p, "manage"])
            permissions_to_add.push(permission_row)
        end
        return permissions_to_add            
    end
    
    def self.organize_permissions
        permissions = Permission.all

        table = []
        read = []
        create = []
        update = []
        destroy = []
        manage = []

        permissions.each do |p|
            if p.action == "read" 
                table.push(p.table)
                read.push(p.id)                
            elsif p.action == "create" 
                create.push(p.id)
            elsif p.action == "update" 
                update.push(p.id)
            elsif p.action == "destroy" 
                destroy.push(p.id)
            elsif p.action == "manage" 
                manage.push(p.id)
            end
        end
        return sorted_permissions = [table, read, create, update, destroy, manage].transpose
    end
end

