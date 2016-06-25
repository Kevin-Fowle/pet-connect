class Event < ActiveRecord::Base
  belongs_to :pairing
  belongs_to :pet_owner_timeslot
end
