class User < ActiveRecord::Base
  belongs_to :organization
  has_many :pets

  has_secure_password

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def pet_owner?
    !!pets && pets.length > 0
  end

  def organization_member?
    !!organization
  end
end
