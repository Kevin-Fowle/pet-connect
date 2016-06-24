class Organization < ActiveRecord::Base
  has_many :representatives, class_name: "User"
end
