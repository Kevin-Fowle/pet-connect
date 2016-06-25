class Organization < ActiveRecord::Base
  has_one :representative, class_name: "User"
  has_many :pairings

  def full_address
    "#{self.street_address},  #{self.city}, #{self.state},  #{self.zip_code}"
  end

  def self.search(search_input)
    where('name LIKE ?', "%#{search_input}%")
  end

  def conversations
    conversation_coll = []
    self.try(:pairings).each do |pairing|
      conversation = {}
      conversation[pairing.pet_owner.full_name] = pairing.try(:messages)
      conversation_arr << conversation
    end
    conversation_arr
  end
end
