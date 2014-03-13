class User < ActiveRecord::Base
  class NotAuthorized < ActiveRecord::ActiveRecordError;end
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :hotels
  has_many :ratings
end
