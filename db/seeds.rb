# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  name: "adminmin",
  email: "admin@email.com",
  password: "adminadmin",
  admin: true
)

5.times do |n|
  User.create!(
      name: "user#{n+10}",
      email: "#{n+10}@email.com",
      password: "#{n+10}aaaaaa",
      admin: false
  )
end
