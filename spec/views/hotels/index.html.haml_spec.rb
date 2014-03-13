require 'spec_helper'

describe "hotels/index" do
  before(:each) do
    assign(:hotels, [
      stub_model(Hotel,
        :title => "Title",
        :rating => 1,
        :breakfast_included => false,
        :description => "MyText",
        :price => 1.5
      ),
      stub_model(Hotel,
        :title => "Title",
        :rating => 1,
        :breakfast_included => false,
        :description => "MyText",
        :price => 1.5
      )
    ])
  end

  it "renders a list of hotels" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
  end
end
