class Organization < ActiveRecord::Base
  has_one :representative, class_name: "User"
  has_many :pairings

  # def self.search(input)
  #   Organization.where('name LIKE ?', "#{input}%").limit(5)

  # end

  #   Spin off into module (similar method as user)?
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
