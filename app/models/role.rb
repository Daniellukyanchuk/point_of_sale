class Role < ApplicationRecord
    has_many :users, through: :role_users
    has_many :role_users
    has_many :role_permissions
    has_many :permissions, through: :role_permissions
    accepts_nested_attributes_for :role_permissions , allow_destroy: true

    def self.get_permissions
        sql =     
             """
             SELECT tablename
             FROM pg_catalog.pg_tables
             WHERE   schemaname != 'pg_catalog' AND 
                     schemaname != 'information_schema' AND
                     tablename NOT IN ('schema_migrations', 'ar_internal_metadata');
             """
             results = ActiveRecord::Base.connection.execute(sql)
     
             results.each do |table|
                 table_permissions = []
                     table_permissions.push([table["tablename"], "read"])
                     table_permissions.push([table["tablename"], "write"])
                     table_permissions.push([table["tablename"], "destroy"])
                     table_permissions.push([table["tablename"], "all"])
                    
                 return table_permissions 
                 
             end
         end
end
