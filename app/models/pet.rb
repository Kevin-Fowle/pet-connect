class Pet < ActiveRecord::Base
  belongs_to :pet_owner, class_name: :User
end
