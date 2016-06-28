class Event < ActiveRecord::Base
  belongs_to :pet_owner, class_name: "User", foreign_key: :user_id
  belongs_to :organization

  def self.open
    where("organization_id IS NULL")
  end

  def self.requested
    where.not("organization_id IS NULL")
  end

  def self.scheduled
    self.requested.where(accepted: true)
  end
end