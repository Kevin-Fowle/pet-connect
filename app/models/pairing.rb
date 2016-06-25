class Pairing < ActiveRecord::Base
  belongs_to :pet_owner, class_name: "User"
  belongs_to :organization
  has_many :messages
end
