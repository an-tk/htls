require 'spec_helper'

describe "hotels/show" do
  before(:each) do
    @hotel = assign(:hotel, stub_model(Hotel,
      :title => "Title",
      :rating => 1,
      :breakfast_included => false,
      :description => "MyText",
      :price => 1.5
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/1/)
    rendered.should match(/false/)
    rendered.should match(/MyText/)
    rendered.should match(/1.5/)
  end
end
