# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# default admin user
u = User.new
u.name = "Admin"
u.email = "admin@localhost"
u.password= "secret"
u.password_confirmation = "secret"
u.admin = 1
u.save


