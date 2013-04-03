require 'spec_helper'

describe "PageCategories" do
  describe "GET /page_categories" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get page_categories_path
      response.status.should be(200)
    end
  end
end
