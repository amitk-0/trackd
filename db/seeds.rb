require 'securerandom'

TEMP_PASSWORD = 'Whitebox@123'
puts 'Creating Users '

users = [
  { first_name: 'Amit', last_name: 'K', email: 'amit.k@example.com', password: TEMP_PASSWORD },
  { first_name: 'Robert', last_name: 'Bach', email: 'robert.bach@example.com', password: TEMP_PASSWORD }
]

User.delete_all
users.each do |user_params|
  User.create!(user_params)
end

8.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = (first_name + '.' + last_name + '@example.com').downcase
  User.create!(first_name: first_name, last_name: last_name, email: email, password: TEMP_PASSWORD)
  print '.'
end

puts "\nCreating Projects "
Project.delete_all
projects = [
  { title: 'Robo Advisor', code: 'RA', description: 'Takes care of development of RoboAdvisor platform' },
  { title: 'Human Resources', code: 'HR', description: 'All the recruitment and personnel management activities will be tracked here' },
  { title: 'Marketing and Sales', code: 'MARSL', description: 'Branding, Marketing and Sales activities will be added to this project' }
]
projects.each do |project|
  Project.find_or_create_by!(title: project[:title], code: project[:code], description: project[:description])
  print '.'
end
