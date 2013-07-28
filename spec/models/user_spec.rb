# encoding: utf-8

require 'spec_helper'

describe User do
  it { should have_many(:pages) }
  it { should validate_uniqueness_of :name }
  it { should validate_presence_of :name }
  it { should validate_presence_of :role }

  let(:params) { nil }
  subject { FactoryGirl.build(:user, params) }

  # 正常入力
  context "with normal input" do
    let(:params) { {
      password: 'hoge_pass',
      password_confirmation: 'hoge_pass'
    } }

    it "is valid" do
      subject.valid?.should be_true
      subject.password_digest.should_not be_empty
    end

    it "should be authenticated" do
      subject.authenticate('hoge_pass').should == subject
    end
  end

  # パスワードと確認入力が一致しない場合
  context "with password isn't equal to confirmation input" do
    let(:params) {
      {
        password: 'password_hogehoge',
        password_confirmation: 'password_hugahuga'
      }
    }

    it "is not valid" do
      subject.valid?.should be_false
      # 確認入力フィールドにエラーあり
      subject.errors[:password].should_not be_empty
    end
  end

  # パスワードが空欄の場合
  context "with empty passwords" do
    # ユーザ作成時
    context "when it creates" do
      let(:params) {
        {
          password: nil,
          password_confirmation: nil
        }
      }

      it "is not valid" do
        subject.valid?.should be_false
      end
    end

    # ユーザ更新時
    context "when it updates" do
      subject { FactoryGirl.create(:user) }

      it "is valid" do
        subject.attributes = { password: nil, password_confirmation: nil }
        subject.valid?.should be_true
      end
    end
  end

  context "with admin role" do
    subject { FactoryGirl.build(:user, role: "admin") }

    describe "#admin?" do
      it { expect(subject.admin?).to be_true }
    end

    describe "#manager?" do
      it { expect(subject.manager?).to be_false }
    end

    describe "#blogger?" do
      it { expect(subject.blogger?).to be_false }
    end
  end

  context "with manager role" do
    subject { FactoryGirl.build(:user, role: "manager") }

    describe "#admin?" do
      it { expect(subject.admin?).to be_false }
    end

    describe "#manager?" do
      it { expect(subject.manager?).to be_true }
    end

    describe "#blogger?" do
      it { expect(subject.blogger?).to be_false }
    end
  end

  context "with blogger role" do
    subject { FactoryGirl.build(:user, role: "blogger") }

    describe "#admin?" do
      it { expect(subject.admin?).to be_false }
    end

    describe "#manager?" do
      it { expect(subject.manager?).to be_false }
    end

    describe "#blogger?" do
      it { expect(subject.blogger?).to be_true }
    end
  end
end
