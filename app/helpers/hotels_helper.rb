module HotelsHelper
  def owner?(hotel, user)
    hotel.user == user
  end
end
