require 'spec_helper'

describe "page_categories/new" do
  before(:each) do
    assign(:page_category, stub_model(PageCategory,
      :name => "MyString",
      :title => "MyString"
    ).as_new_record)
  end

  it "renders new page_category form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", page_categories_path, "post" do
      assert_select "input#page_category_name[name=?]", "page_category[name]"
      assert_select "input#page_category_title[name=?]", "page_category[title]"
    end
  end
end
