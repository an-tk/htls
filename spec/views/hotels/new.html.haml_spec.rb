require 'spec_helper'

describe "hotels/new" do
  before(:each) do
    assign(:hotel, stub_model(Hotel,
      :title => "MyString",
      :rating => 1,
      :breakfast_included => false,
      :description => "MyText",
      :price => 1.5
    ).as_new_record)
  end

  it "renders new hotel form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", hotels_path, "post" do
      assert_select "input#hotel_title[name=?]", "hotel[title]"
      assert_select "input#hotel_rating[name=?]", "hotel[rating]"
      assert_select "input#hotel_breakfast_included[name=?]", "hotel[breakfast_included]"
      assert_select "textarea#hotel_description[name=?]", "hotel[description]"
      assert_select "input#hotel_price[name=?]", "hotel[price]"
    end
  end
end
