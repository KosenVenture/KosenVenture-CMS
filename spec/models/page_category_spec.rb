# encoding: utf-8

require 'spec_helper'

describe PageCategory do
  fixtures :page_categories, :pages
  let(:params) { nil }
  subject { PageCategory.new(params) }

  # 正常入力時
  context "with normal input" do
    let(:params) { { name: 'hoge' } }

    it "is valid" do
      subject.valid?.should be_true
    end

    it "has many pages" do
      # fixtureに関連レコードを入れてある
      subject.pages.should_not be_nil
    end
  end

  # 全空欄入力時
  context "with nil input" do
    let(:params) { nil }

    it "is not valid" do
      subject.valid?.should be_false
    end
  end

  # 日本語名の場合
  context "with Japanese name input" do
    let(:params) { { name: 'ほげ' } }

    it "is not valid" do
      subject.valid?.should be_false
    end
  end
end
