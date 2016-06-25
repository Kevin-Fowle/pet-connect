class Message < ActiveRecord::Base
  belongs_to :pairing
  belongs_to :user
end
