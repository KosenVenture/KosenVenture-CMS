require 'spec_helper'

describe BlogPost do
  it { should belong_to :author }
  it { should belong_to :category }

  let(:params) { nil }
  subject { FactoryGirl.build(:blog_post, params) }

  # 正常入力時
  context "with normal input" do
    let(:params) {{
      title: "タイトル",
      author: author,
      category: category
    }}
    let(:author) { FactoryGirl.create(:user) }
    let(:category) { FactoryGirl.create(:blog_category) }

    it "belongs to category" do
      expect(subject.category).to eq category
    end

    it "belongs to author" do
      expect(subject.author).to eq author
    end

    it "is valid" do
      expect(subject.valid?).to be_true
    end
  end
end
