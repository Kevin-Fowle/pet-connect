# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# client = SODA::Client.new({:domain => "explore.data.gov", :app_token => "CGxadgoQlgQSev4zyUh5aR5J3"})
require 'net/http'
require 'json'


resp = Net::HTTP.get_response(URI("https://data.medicare.gov/resource/rbry-mqwu.json?$limit=50000"))
hospitals_json = JSON.parse(resp.body)

hospitals_json.each do |hospital|
  Organization.create(
    name: hospital['hospital_name'],
    street_address: hospital['location_address'],
    city: hospital['location_city'],
    zip_code: hospital['location_zip'],
    state: hospital['location_state'],
    phone: hospital['phone_number'])
end

User.create!(
  first_name: "Maurice",
  last_name: "Rabb",
  street_address: "123 Sesame St.",
  city: "Chicago",
  zip_code: "60001",
  state: "IL",
  password: "momo",
  email: "momo@momo.org"
)

User.create!(
  first_name: "Matt",
  last_name: "Baker",
  street_address: "321 ",
  city: "Chicago",
  zip_code: "60002",
  state: "IL",
  password: "unfuck",
  email: "matt@baker.io",
  organization_id: 1
)

Pet.create!(
name: "Hey Jay Query",
species: "Rabbit",
breed: "American Sable",
weight: 3,
description: "I have a pet rabbit. Her name is Hey Jay Query. She is very cute. She plays with me. She hops when she is happy. We play running race. She runs very fast and wins. She loves to eat carrots. I keep her in a big and beautiful basket. Every morning when I get up, I run to the basket to greet my bunny. When I call her she shakes her ears and looks at me with her beautiful eyes. I love my pet rabbit very much.",
user_id: User.find_by(email: "momo@momo.org").id,
avatar: File.new("app/assets/images/momos-bunny.jpg")
)





# 15.times do |i|
#   f_name = Faker::Name.first_name
#
#   user = User.new(
#     first_name: f_name,
#     last_name: Faker::Name.last_name,
#     email: Faker::Internet.free_email(f_name),
#     password: Faker::Internet.password,
#     street_address: Faker::Address.street_address,
#     city: Faker::Address.city,
#     zip_code: Faker::Address.zip,
#     state: Faker::Address.state_abbr,
#     organization: Organization.find(i + 1))
#
#   user.save
# end
#
# 15.times do |i|
#   f_name = Faker::Name.first_name
#
#   user = User.new(
#     first_name: f_name,
#     last_name: Faker::Name.last_name,
#     email: Faker::Internet.free_email(f_name),
#     password: Faker::Internet.password,
#     street_address: Faker::Address.street_address,
#     city: Faker::Address.city,
#     zip_code: Faker::Address.zip,
#     state: Faker::Address.state_abbr)
#
#   user.save
#
#   (2..5).to_a.sample.times do |i|
#     Pet.create(
#       name: Faker::Name.first_name,
#       species: "dog",
#       breed: "Big Dog",
#       weight: (10..80).to_a.sample,
#       description: Faker::Hipster.paragraph,
#       owner: user)
#   end
#
#   (2..5).to_a.sample.times do |i|
#     organization = Organization.all.sample
#     pairing = Pairing.create(
#       pet_owner: user,
#       organization: organization)
#       (2..5).to_a.sample.times do |i|
#         Message.create(
#           subject: Faker::Hipster.sentence,
#           body: Faker::Hipster.paragraph,
#           messageable: [user, organization].sample)
#       end
#   end
#
#   (2..5).to_a.sample.times do |i|
#     Event.create(
#       date: Faker::Date.forward(23),
#       start_time: Faker::Time.forward(21, :afternoon),
#       end_time: Faker::Time.forward(21, :evening),
#       pet_owner: user)
#   end
# end
