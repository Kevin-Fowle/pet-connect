include UserHelper

class Rating < ActiveRecord::Base
  belongs_to :ratable, polymorphic: true
end
