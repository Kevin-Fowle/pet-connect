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


resp = Net::HTTP.get_response(URI("https://data.medicare.gov/resource/rbry-mqwu.json"))
hospitals_json = JSON.parse(resp.body)

hospitals_json.each do |hospital|
  Organization.create(name: hospital['hospital_name'], street_address: hospital['location_address'], city: hospital['location_city'], zip_code: hospital['location_zip'], state: hospital['location_state'], phone: hospital['phone_number'] )
end
