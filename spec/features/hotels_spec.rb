require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe 'Hotels' do
  before :each do
    @user = User.create(:email => 'user@example.com', :password => '1111')
    @hotel = @user.hotels.create(:title => 'user hotel', :stars => '3')
    Hotel.create(:title => 'common hotel', :stars => '4')
  end

  describe 'User going to hotels list' do
    it 'should display list of hotels' do
      visit hotels_path
      page.should have_content 'Listing hotels'
      page.should have_content 'user hotel'
      page.should have_content 'common hotel'
      page.should have_selector '.list-group .list-group-item'
    end
  end
  describe 'Logged in user creates hotel' do
    before { login_as(@user, scope: :user)}
    it 'should create hotel if valid attributes' do
      visit hotels_path
      click_link 'New Hotel'
      within('#new_hotel') do
        fill_in 'Title', with: 'valid hotel'
        fill_in 'Stars', with: '5'
      end
      click_button 'Create Hotel'
      page.should have_content 'valid hotel'
      page.should have_content 'Hotel was successfully created.'
    end
  end

  describe 'Not logged in user can not create hotel' do
    it 'should not display "New Hotel" link' do
      visit hotels_path

      page.should_not have_content 'New Hotel'
    end

    it 'should not allow user to visit new hotel page' do
      visit new_hotel_path
      page.should have_content 'You need to sign in or sign up before continuing.'
    end
  end
end
