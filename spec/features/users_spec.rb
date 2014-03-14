require 'spec_helper'


describe 'Users', :type => :feature  do
  describe 'Register' do
    it 'can register' do
      visit '/users/sign_up'
      within('#new_user') do
        fill_in 'Email', :with => 'user@example.com'
        fill_in 'Password', :with => '1111'
        fill_in 'Password confirmation', :with => '1111'
      end
      click_button 'Sign up'
      expect(page).to have_content 'Welcome: user@example.com'
    end
  end
  describe 'Sign in' do
    before :all do
      User.create(:email => 'user@example.com', :password => '1111')
    end
    it 'can sign in with correct credentials' do
      visit '/users/sign_in'
      within('#new_user') do
        fill_in 'Email', :with => 'user@example.com'
        fill_in 'Password', :with => '1111'
      end
      click_button 'Sign in'
      expect(page).to have_content 'Signed in successfully.'
    end
    it 'get error with incorrect credentials' do
      visit '/users/sign_in'
      within('#new_user') do
        fill_in 'Email', :with => 'user@example.com'
        fill_in 'Password', :with => 'wrong pass'
      end
      click_button 'Sign in'
      expect(page).to have_content 'Invalid email or password.'
    end
  end
end
