class User < ActiveRecord::Base
  belongs_to :organization
  has_many :pets

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
end
