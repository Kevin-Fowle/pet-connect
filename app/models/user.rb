class User < ActiveRecord::Base
  has_many :pets
  has_many :pairings
  has_many :messages
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

  def organization_user?
    !!organization
  end

  def pet_owner?
    !!pets && pets.length > 0
  end

  def title
    if organization_user?
      organization.name
    else
      full_name
    end
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

  def conversations
    conversation_arr = []
    self.try(:pairings).each do |pairing|
      conversation = {}
      if organization_user?
        message_to = pairing.pet_owner.full_name
      else
        message_to = pairing.organization.name
      end
      conversation[message_to] = pairing.try(:messages)
      conversation_arr << conversation
    end
  end

  def self.org_users 
    where.not("organization_id IS NULL")
  end

  def self.pet_owners
    where("organization_id IS NULL")
  end
end
