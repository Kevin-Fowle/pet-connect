class Message < ActiveRecord::Base
  belongs_to :pairing
  belongs_to :messageable, polymorphic: true
end
