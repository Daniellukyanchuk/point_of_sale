# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

unless User.exists?(:user_name => "POS Admin")
    #add admin role
    admin_role = Role.create(:role_name => "System Admin")
    #get id of admin role
    role_id = admin_role.id
    #create admin user
    admin_user = User.create(:user_name => "POS Admin", :email => "quickfoxcreative@gmail.com", :password => "123456")
    #get id of admin user
    user_id = admin_user.id
    #assign role to user
    RoleUser.create(:user_id => user_id, :role_id => role_id)
end

if Setting.count == 0
    Setting.create(company_name: "Company Name", company_address: "Company Address", company_phone: "+999 (999) 999 999")
end
