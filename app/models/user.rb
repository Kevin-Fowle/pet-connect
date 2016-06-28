include UserHelper

class User < ActiveRecord::Base
  has_many :pets
  has_many :pairings
  has_many :messages, as: :messageable
  has_many :events
  has_many :ratings, as: :ratable
  belongs_to :organization

  validates :first_name, presence: true, length: {maximum: 15}
  validates :last_name, presence: true, length: {maximum: 15}
  validates :email, { presence: true, uniqueness: true }
  validates :street_address, presence: true
  validates :city, presence: true
  validates :zip_code, presence: true
  validates :state, presence: true


  has_secure_password

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  alias_method :name, :full_name


  def pet_owner?
    !!pets && pets.length > 0
  end

  def organization_user?
    !!organization
  end

  def behalf_of
    return organization if organization_user?
    self
  end


  def self.org_users
    where.not("organization_id IS NULL")
  end

  def self.pet_owners
    where("organization_id IS NULL")
  end


  def approved_pairings
    pairings.where(org_approved: true)
  end

  def pending_pairings
    pairings.where(org_approved: false)
  end


  def approved_organizations
    approved_pairings.map { |pairing| pairing.organization }
  end

  def pending_organizations
    pending_pairings.map { |pairing| pairing.organization }
  end


  def self.org_users
    where.not("organization_id IS NULL")
  end

  def self.pet_owners
    where("organization_id IS NULL")
  end


  def confirmed_events
    events.where(accepted: true)
  end

  def offered_events
    events.where("organization_id IS NULL")
  end


  def full_address
    "#{self.street_address},  #{self.city}, #{self.state},  #{self.zip_code}"
  end

  def user_rating
    pet_ratings = self.pets.map{|pet| pet.ratings}.flatten
    pet_stars = pet_ratings.map{|rating| rating.stars}.flatten

    if pet_stars.length > 0
      pet_stars.reduce(:+) / pet_stars.length
    else
      0
    end
  end


  def conversations(current_user) ## Module method?
    conversation_arr = []
    self.try(:pairings).each do |pairing|
      conversation = {}
      conversation[pairing.pair(current_user).name] = pairing.try(:messages)
      conversation_arr << conversation
    end
    conversation_arr
  end
end
