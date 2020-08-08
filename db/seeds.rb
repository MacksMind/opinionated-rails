# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.new(
  email: 'mack@agilereasoning.com',
  password: 'change_before_deploy',
  first_name: 'Mack',
  last_name: 'Earnhardt',
  time_zone: 'Eastern Time (US & Canada)',
  company_name: 'Agile Reasoning',
  phone_number: '+1 317.286.6610',
  address_line_1: '12175 Visionary Way Ste 610',
  city: 'Fishers',
  state_code: 'IN',
  postal_code: '46038',
  country_code: 'US'
)

user.roles = User::ROLES
user.skip_confirmation!
user.save!
