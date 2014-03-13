class RatingsController < ApplicationController
  before_action :set_rating, only: [:update, :destroy]
  before_filter :authenticate_user!
  append_before_action :check_if_owner, only: [:update, :destroy]

  def create
    rating = current_user.ratings.new(rating_params)
    if rating.save
      redirect_to rating.hotel, notice: 'Your rating was successfully created.'
    else
      redirect_to rating.hotel, error: 'Your rating was not created.'
    end
  end

  def destroy
    hotel = @rating.hotel
    @rating.destroy
    redirect_to hotel, notice: 'Your rating was removed.'
  end

  def update
    if @rating.update(rating_params)
      redirect_to @rating.hotel, notice: 'Your rating was successfully updated.'
    else
      redirect_to @rating.hotel, error: 'Your rating was not updated.'
    end
  end

  private
  def set_rating
    @rating = params.has_key?('id') ?
        current_user.ratings.find(params['id']) :
        current_user.ratings.find_by_hotel_id(params['rating']['hotel_id'])

  end

  def rating_params
    params.require(:rating).permit(:score, :comment, :hotel_id)
  end

  def check_if_owner
    raise User::NotAuthorized unless current_user == @rating.user
  end
end
