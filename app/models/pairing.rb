class Pairing < ActiveRecord::Base
  belongs_to :pet_owner, class_name: "User", foreign_key: :user_id
  belongs_to :organization
  has_many :messages

  def pair
    return pet_owner if current_user.organization_user?
    organization
  end
end