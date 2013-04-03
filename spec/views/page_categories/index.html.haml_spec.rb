require 'spec_helper'

describe "page_categories/index" do
  before(:each) do
    assign(:page_categories, [
      stub_model(PageCategory,
        :name => "Name",
        :title => "Title"
      ),
      stub_model(PageCategory,
        :name => "Name",
        :title => "Title"
      )
    ])
  end

  it "renders a list of page_categories" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
  end
end
