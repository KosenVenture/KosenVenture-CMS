# encoding: utf-8

require 'spec_helper'

describe Page do
  it { should have_many :children }
  it { should belong_to :parent }
  it { should belong_to :author }
  it { should validate_presence_of :name }

  it { should allow_value('hoge0123456789').for(:name) }
  it { should allow_value('hoge_huga').for(:name) }
  it { should allow_value('HOGE-huga').for(:name) }
  it { should_not allow_value('').for(:name) }
  it { should_not allow_value('!#$%&`').for(:name) }
  it { should_not allow_value('日本語名').for(:name) }

  let(:params) { nil }
  subject { FactoryGirl.build(:page, params) }

  # 正常入力時
  context "with normal input" do
    let(:params) {{
      name: 'hoge',
      title: 'ほげ',
      published: true,
      parent: FactoryGirl.create(:page, name: 'huga', title: 'ふが')
    }}

    it "is valid" do
      subject.valid?.should be_true
    end

    describe "#trace_path" do
      it "returns true path" do
        subject.trace_path.should == '/huga/hoge'
      end
    end
    
    describe "#trace_depth" do
      it "returns true value" do
        subject.trace_depth.should == 1
      end
    end
    
    describe "#tree_title" do
      before do
        subject.__send__(:set_depth)
        subject.__send__(:set_path)
      end

      it "returns true value" do
        subject.tree_title.should == "　■ほげ (/huga/hoge)"
      end
    end
  end

  # 親ページ無しの入力
  context "with no parent input" do
    let(:params) {
      { name: 'no_parent', title: 'ほげ', parent: nil }
    }

    describe "#trace_path" do
      it "returns true path" do
        subject.trace_path.should == '/no_parent'
      end
    end

    describe "#trace_depth" do
      it "returns true value" do
        subject.trace_depth.should == 0
      end
    end

    describe "#tree_title" do
      before do
        subject.__send__(:set_depth)
        subject.__send__(:set_path)
      end

      it "returns true value" do
        subject.tree_title.should == "■ほげ (/no_parent)"
      end
    end
  end

  # 自分自身が親ページの不正入力
  context "with parent is self input" do
    before do
      @page = FactoryGirl.create(:page)
      @page.parent_id = @page.id
    end
    subject { @page }
    let(:params) {{ parent_id: @page.id }}

    describe "#parent_id" do
      it "has error" do
        subject.valid?
        subject.errors[:parent_id].should_not be_empty
      end
    end
  end

  # 全空欄入力時
  context "with nil input" do
    let(:params) { { parent_id: '' } }

    describe "#parent_id" do
      # 空欄は許可
      it "has no errors" do
        subject.valid?
        subject.errors[:parent_id].should be_empty
      end
    end
  end

  # 同じ階層で同名のページ名のとき
  context "with the same name in the same level" do
    before { FactoryGirl.create(:page, name: 'hoge') }
    let(:params) {{ name: 'hoge' }}

    it "is not valid" do
      subject.valid?.should be_false
    end
  end

  # 階層の深さのバリデーションテスト
  context "with too deep nested" do
    before do
      Page::MAX_DEPTH.times do |i|
        @page = FactoryGirl.create(:page, name: "nest_#{i}", parent: @page)
      end
    end
    let(:params) {{ parent: @page }}

    it "is not valid" do
      expect(subject.valid?).to be_false
    end
  end
end
