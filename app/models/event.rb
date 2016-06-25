class Event < ActiveRecord::Base
  belongs_to :pairing
  belongs_to :timeslot
end
