require 'spec_helper'

describe PageNavigationController do
  describe "GET 'navigate'" do
    subject { get :navigate, path: path }

    context "with published page path" do
      let!(:page) { FactoryGirl.create(:page, name: "hoge") }
      let(:path) { "hoge" }

      it "returns http success" do
        expect(subject.status).to eq 200
        expect(assigns(:page)).to eq page
      end
    end

    context "with not exists page path" do
      let(:path) { "huga" }

      it "returns http not found" do
        expect(subject.status).to eq 404
        subject.should render_template("shared/404")
      end
    end

    context "with not published page" do
      let!(:page) { FactoryGirl.create(:page, name: "hage", published: false) }
      let(:path) { "hage" }

      it "returns 404 page" do
        expect(subject.status).to eq 404
        subject.should render_template("shared/404")
      end
    end

    context "with not passed published_at page" do
      let!(:page) { FactoryGirl.create(:page, name: "huga", published: true, published_at: 1.day.from_now) }
      let(:path) { "huga" }

      it "returns 404 page" do
        expect(subject.status).to eq 404
        expect(subject).to render_template("shared/404")
      end
    end

    context "with blank path" do
      let!(:page) { FactoryGirl.create(:page, name: "index") }
      let(:path) { nil }

      it "returns index page" do
        expect(subject.status).to eq 200
        expect(assigns(:page)).to eq page
      end
    end
  end
end
