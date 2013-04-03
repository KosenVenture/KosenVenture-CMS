require 'spec_helper'

describe "page_categories/show" do
  before(:each) do
    @page_category = assign(:page_category, stub_model(PageCategory,
      :name => "Name",
      :title => "Title"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Title/)
  end
end
