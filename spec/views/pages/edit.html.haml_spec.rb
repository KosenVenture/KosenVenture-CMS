require 'spec_helper'

describe "pages/edit" do
  before(:each) do
    @page = assign(:page, stub_model(Page,
      :name => "MyString",
      :title => "MyString",
      :description => "MyText",
      :body => "MyText",
      :category_id => 1,
      :author_id => 1,
      :published => false
    ))
  end

  it "renders the edit page form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", page_path(@page), "post" do
      assert_select "input#page_name[name=?]", "page[name]"
      assert_select "input#page_title[name=?]", "page[title]"
      assert_select "textarea#page_description[name=?]", "page[description]"
      assert_select "textarea#page_body[name=?]", "page[body]"
      assert_select "input#page_category_id[name=?]", "page[category_id]"
      assert_select "input#page_author_id[name=?]", "page[author_id]"
      assert_select "input#page_published[name=?]", "page[published]"
    end
  end
end
