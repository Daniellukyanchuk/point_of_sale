# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if User.count == 0
    Role.create(role_name: "System Admin")
    User.create(email: "quickfoxcreative@gmail.com", password: "123456", role_users_attributes: [user_id: 1, role_id: 1]))
end
