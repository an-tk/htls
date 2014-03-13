class Rating < ActiveRecord::Base
  belongs_to :hotel
  belongs_to :user
  validates :user_id, :uniqueness => {:scope => :hotel_id}
end
