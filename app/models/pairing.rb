class Pairing < ActiveRecord::Base
  include UserHelper

  belongs_to :pet_owner, class_name: "User", foreign_key: :user_id
  belongs_to :organization
  has_many :messages

  def pair(current_user)
    return pet_owner if current_user.organization_user?
    organization
  end
end