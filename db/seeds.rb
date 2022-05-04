# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if Setting.count == 0
	Setting.create(company_name: "My Company")
end

if Role.count == 0
	Role.create!(role_name: 'Admin')
end

if Permission.count == 0
	Permission.create!(table: "all", action: "manage")
end

role = Role.where('Admin')
permissions = Permission.where(table: "all", action: "manage")
role.permissions = permissions

user = User.new(email: 'daniellukyanchuk@gmail.com', password: "12345pass", password_confirmation: "12345pass")
user.role = role
user.save!

if User.count == 0
  User.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
end




