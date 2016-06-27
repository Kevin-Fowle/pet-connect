include UserHelper

class Event < ActiveRecord::Base
  belongs_to :pet_owner, class_name: "User", foreign_key: :user_id
  belongs_to :organization
end
