# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if User.count == 0
    User.create(email: "quickfoxcreative@gmail.com", password: "123456")
end

if Setting.count == 0
    Setting.create(company_name: "Company Name", company_address: "Company Address", company_phone: "+999 (999) 999 999")
end
