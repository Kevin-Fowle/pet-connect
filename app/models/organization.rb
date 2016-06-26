class Organization < ActiveRecord::Base
  has_one :representative, class_name: "User"
  has_many :pairings

  def full_address
    "#{self.street_address},  #{self.city}, #{self.state},  #{self.zip_code}"
  end

  def self.search(search_input)
    where('name LIKE ?', "%#{search_input}%").limit(10)
  end

  def approved_pairings
    pairings.where(org_approved: true)
  end

  def pending_pairings
    pairings.where(org_approved: false)
  end

  def approved_pet_owners
    approved_pairings.map { |pairing| pairing.pet_owner }
  end

  def pending_pet_owners
    pending_pairings.map { |pairing| pairing.pet_owner }
  end

  def approved_events
    approved_pet_owners.events
  end

  def pending_events
    pending_pet_owners.events
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

  def approved_users
    approved_users = self.pairings.map { |pairing| pairing.active }
  end
end
