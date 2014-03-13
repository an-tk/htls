class HotelsController < ApplicationController
  before_action :set_hotel, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:new, :edit, :update, :destroy, :create]
  append_before_action :check_if_owner, only: [:edit, :update, :destroy]


  # GET /hotels
  # GET /hotels.json
  def index
    @hotels = Hotel.all.page params[:page]
  end

  def top
    @hotels = Hotel.top.limit(5)
  end

  def show
    if user_signed_in?
      @rating = Rating.where(:user_id => current_user.id, :hotel_id => @hotel.id).first
      @rating = @hotel.ratings.new() if @rating.nil?
    end
  end

  # GET /hotels/new
  def new
    @hotel = Hotel.new
  end

  # GET /hotels/1/edit
  def edit
  end

  # POST /hotels
  # POST /hotels.json
  def create
    @hotel = current_user.hotels.new(hotel_params)

    respond_to do |format|
      if @hotel.save
        format.html { redirect_to @hotel, notice: 'Hotel was successfully created.' }
        format.json { render action: 'show', status: :created, location: @hotel }
      else
        format.html do
          flash[:error] = @hotel.errors.full_messages.to_sentence
          render action: 'new'
        end
        format.json { render json: @hotel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hotels/1
  # PATCH/PUT /hotels/1.json
  def update
    respond_to do |format|
      if @hotel.update(hotel_params)
        format.html { redirect_to @hotel, notice: 'Hotel was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @hotel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hotels/1
  # DELETE /hotels/1.json
  def destroy
    @hotel.destroy
    respond_to do |format|
      format.html { redirect_to hotels_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hotel
      @hotel = Hotel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hotel_params
      params.require(:hotel).permit(:title, :stars, :breakfast_included, :description, :price, :logo, address_attributes:[:country, :state, :street, :city])
    end

    #
    def check_if_owner
      raise User::NotAuthorized unless current_user == @hotel.user
    end
end
