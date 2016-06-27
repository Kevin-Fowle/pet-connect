class Rating < ActiveRecord::Base
  belongs_to :event
  belongs_to :ratable, polymorphic: true

end
