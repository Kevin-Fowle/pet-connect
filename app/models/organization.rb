class Organization < ActiveRecord::Base
  has_one :representative, class_name: "User"
  has_many :pairings
  has_many :events
  has_many :messages, as: :messageable

  def full_address
    "#{self.street_address}, #{self.city}, #{self.state},  #{self.zip_code}"
  end

  def self.search(search_input)
    #is there user with this id
    where('name LIKE ? ', "%#{search_input}%").limit(10)
  end


  def has_representative?
    !!self.representative
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

  def all_connected_owners
    approved_pet_owners + pending_pet_owners
  end


  def approved_events
    approved_events_arr = []
    approved_pet_owners.each do |approved_owner|
      approved_events_arr += approved_owner.offered_events
    end
    approved_events_arr
  end

  def pending_events
    pending_events_arr = []
    pending_pet_owners.each do |pending_owner|
      pending_events_arr += pending_owner.offered_events
    end
    pending_events_arr
  end

  def all_available_events
    approved_events + pending_events
  end

  def requested_events
    events.where("accepted IS NULL")
  end

  def scheduled_events
    events.where(accepted: true)
  end


  def conversations(*current_user)
    conversation_arr = []
    self.try(:pairings).each do |pairing|
      if pairing.messages && pairing.messages.length > 0
        conversation = {}
        conversation[pairing.pet_owner.name] = pairing.messages
        conversation_arr << conversation
      end
    end
    conversation_arr
  end

  def inactive?
    self.representative == nil
  end

  def average_rating
    ratings = self.ratings
    if ratings.length > 0
    ratings.reduce(:+) / ratings.length
    else
      0
    end
  end

   def user_rating
    pet_rating = self.pets.map{|pet| pet.ratings}.flatten
    if pet_rating.length > 0
      pet_rating.reduce(:+) / pet_rating.length
    else
      0
    end
  end
end
