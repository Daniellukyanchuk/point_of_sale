# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if User.count == 0    

    #add admin role
    admin_role = Role.new(role_name: "System Admin")
    admin_role.save!
    #add admin user w/ admin role
    role_id = Role.where("role_name = ?", "System Admin").first.id
    admin_user = User.new(:user_name => "System Admin", :email => "quickfoxcreative@gmail.com", :password => "123456")
    admin_user.role_users.push(:role_id => role_id)
    admin_user.save!
end

if Setting.count == 0
    Setting.create(company_name: "Company Name", company_address: "Company Address", company_phone: "+999 (999) 999 999")
end
