class Organization < ActiveRecord::Base
  has_many :representatives, class_name: "User"


  def full_address
    "#{self.street_address},  #{self.city}, #{self.state},  #{self.zip_code}"
  end

  def self.search(search_input)
    where('name LIKE ?', "%#{search_input}%")
  end
end
