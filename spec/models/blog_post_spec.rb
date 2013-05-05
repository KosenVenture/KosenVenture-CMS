require 'spec_helper'

describe BlogPost do
  fixtures :users
  let(:params) { nil }
  subject { BlogPost.new(params) }

  # 正常入力時
  context "with normal input" do
    let(:params) {
      { id: 5000, name: 'normalpage', published: true, category_id: 1, author_id: 1, parent_id: 1, path: '/about/normalpage', priority: 0.5 }
    }

    it "belongs to category" do
      subject.category.should_not be_nil
    end

    it "belongs to author" do
      subject.author.should_not be_nil
    end

    it "belongs to parent page" do
      subject.parent.should_not be_nil
    end

    it "has many children pages" do
      subject.children.should_not be_empty
      subject.children.count.should == 3
    end

    it "is valid" do
      subject.valid?.should be_true
    end

    describe "#trace_path" do
      it "returns true path" do
        subject.trace_path.should == '/about/normalpage'
      end
    end
  end
end
