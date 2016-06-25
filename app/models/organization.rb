class Organization < ActiveRecord::Base
  has_many :representatives, class_name: "User"



  def self.search(search_input)
    where('name LIKE ?', "%#{search_input}%")

  end
end
