class Organization < ActiveRecord::Base
  has_many :representatives, class_name: "User"



  # def self.search(input)
  #   Organization.where('name LIKE ?', "#{input}%").limit(5)

  # end
end
