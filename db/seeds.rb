# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

unless Role.exists?(:role_name => "System Admin")
    #create admin role
    admin_role = Role.create(:role_name => "System Admin")
end
    

unless User.exists?(:user_name => "Admin")
    #create admin user
    admin_user = User.create(:user_name => "Admin", :email => "quickfoxcreative@gmail.com", :password => "123456")
end

user_id = User.where(:user_name => "Admin").first.id
role_id = Role.where(:role_name => "System Admin").first.id

unless RoleUser.exists?(:role_id => role_id, :user_id => user_id)    
    #create role user
    RoleUser.create(:user_id => user_id, :role_id => role_id)
end

if Setting.count == 0
    Setting.create(company_name: "Company Name", company_address: "Company Address", company_phone: "+999 (999) 999 999")
end


