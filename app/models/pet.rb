class Pet < ActiveRecord::Base
  belongs_to :owner, class_name: "User", foreign_key: :user_id
  has_many :ratings, as: :ratable


  validates :name, presence: true, length: {maximum: 15}
  validates :species, presence: true
  validates :breed, presence: true
  validates :weight,  numericality: { only_integer: true }
  validates :description, presence: true, length: {maximum: 500}
  validates :avatar, presence: true

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>", croppable: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  def average_rating
   ratings = self.ratings
   if ratings.length > 0
   ratings.reduce(:+) / ratings.length
   else
     0
   end
 end
end
