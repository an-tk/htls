class Hotel < ActiveRecord::Base
  paginates_per 5
  mount_uploader :logo, LogoUploader
  has_many :ratings
  has_one :address
  belongs_to :user

  accepts_nested_attributes_for :address, reject_if: :all_blank

  scope :top, -> { select('hotels.* , avg(ratings.score) AS rating_average')
                   .joins('INNER JOIN ratings ON ratings.hotel_id = hotels.id')
                   .group('hotels.id').order('rating_average DESC')


  }

  validates :title, presence: true
  validates :stars, presence: true, inclusion: { in: 1..7, message: "%{value} is not valid. Should be in range 1..7" } #TODO move message to locale file
  validates :price, numericality: { only_integer: true }, allow_blank: true


  def full_address
    full_address = []
    %w(country state city street).each do |attr|
      full_address << self.address.send(attr) if self.address.send(attr).present?
    end
    full_address.join(', ')
  end

  def avg_rating
    ratings = self.ratings.where("ratings.score IS NOT NULL")
    ratings.sum(:score).to_f/ratings.count
  end
end
