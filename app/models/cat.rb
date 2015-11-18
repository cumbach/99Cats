class Cat < ActiveRecord::Base
  COLORS = ["red", "orange", "yellow", "green", "blue", "purple", "black", "white", "calico"]

  validates :name, :color, :sex, presence: true
  validates :color, inclusion: { in: COLORS, message: "%{value} is not a valid color" }
  validates :sex, inclusion: { in: %w(M F),
    message: "%{value} is not a valid sex"}

  has_many :cat_rental_requests, dependent: :destroy,
    class_name: "CatRentalRequest",
    foreign_key: :cat_id,
    primary_key: :id

  def age
    now = Date.today
    difference_in_days = (now-birth_date).to_i
    (difference_in_days/365.25).to_i
  end

end
