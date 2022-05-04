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

unless Role.exists?(role_name: 'Admin')
	Role.create!(role_name: 'Admin')
end
role_id = Role.where(role_name: 'Admin').first.id

unless User.exists?(user_name: 'St.Joerg')
	User.create!(user_name: 'St.Joerg', email: 'daniellukyanchuk@gmail.com', password: "12345pass", password_confirmation: "12345pass")
end
user_id = User.where(user_name: 'St.Joerg').first.id

unless RoleUser.exists?(user_id: user_id, role_id: role_id)
	RoleUser.create!(user_id: user_id, role_id: role_id)
end

if User.count == 0
  User.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
end




