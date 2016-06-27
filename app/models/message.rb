class Message < ActiveRecord::Base
  belongs_to :pairing
  belongs_to :messageable, polymorphic: true

  def author(current_user)
    pairing.pair(current_user)
  end
end
