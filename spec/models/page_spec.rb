# encoding: utf-8

require 'spec_helper'

describe Page do
  fixtures :pages, :page_categories, :users
  let(:params) { nil }
  subject { Page.new(params) }

  # 正常入力時
  context "with normal input" do
    let(:params) {
      { name: 'normalpage', published: true, category_id: 1, author_id: 1 }
    }

    it "belongs to category" do
      subject.category.should_not be_nil
    end

    it "belongs to author" do
      subject.author.should_not be_nil
    end

    it "is valid" do
      subject.valid?.should be_true
    end
  end

  # 全空欄入力時
  context "with nil input" do
    let(:params) { nil }

    describe "#name" do
      it "has errors" do
        subject.valid?.should be_false
        subject.errors[:name].count.should_not == 0
      end
    end

    describe "#category_id" do
      # 空欄は許可
      it "has no errors" do
        subject.valid?
        subject.errors[:category_id].count.should == 0
      end
    end

    describe "#category" do
      # 空欄は許可
      # nilを返すこと
      it "returns nil" do
        subject.category.should be_nil
      end
    end
  end

  # 日本語名の場合
  context "with Japanese name input" do
    let(:params) { { name: 'ほげ', published: true, category_id: 1, author_id: 1 } }

    it "is not valid" do
      subject.valid?.should be_false
    end
  end
end
