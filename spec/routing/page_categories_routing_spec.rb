require "spec_helper"

describe PageCategoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/page_categories").should route_to("page_categories#index")
    end

    it "routes to #new" do
      get("/page_categories/new").should route_to("page_categories#new")
    end

    it "routes to #show" do
      get("/page_categories/1").should route_to("page_categories#show", :id => "1")
    end

    it "routes to #edit" do
      get("/page_categories/1/edit").should route_to("page_categories#edit", :id => "1")
    end

    it "routes to #create" do
      post("/page_categories").should route_to("page_categories#create")
    end

    it "routes to #update" do
      put("/page_categories/1").should route_to("page_categories#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/page_categories/1").should route_to("page_categories#destroy", :id => "1")
    end

  end
end
