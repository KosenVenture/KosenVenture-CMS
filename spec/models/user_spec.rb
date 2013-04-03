# encoding: utf-8

require 'spec_helper'

describe User do
  let(:params) { nil }
  subject { User.new(params) }

  # 正常入力
  context "with normal input" do
    let(:params) {
      {
        name: 'huga-hoge_ho09A',
        real_name: 'hoge huga',
        password: 'password_hogehoge',
        password_confirmation: 'password_hogehoge'
      }
    }

    it "is valid" do
      subject.valid?.should be_true
      subject.password_digest.should_not be_empty
    end
  end

  # 全空欄入力
  context "with all nil input" do
    let(:params) { nil }

    it "is not valid" do
      subject.valid?.should be_false
      subject.errors[:name].should_not be_empty
      subject.errors[:password].should_not be_empty
    end
  end

  # パスワードと確認入力が一致しない場合
  context "with password isn't equal to confirmation input" do
    let(:params) {
      {
        name: 'huga',
        real_name: 'hoge huga',
        password: 'password_hogehoge',
        password_confirmation: 'password_hugahuga'
      }
    }

    it "is not valid" do
      subject.valid?.should be_false
      # 確認入力フィールドにエラーあり
      subject.errors[:password_confirmation].should_not be_empty
    end
  end

  # パスワードが空欄の場合
  context "with empty passwords" do
    # ユーザ作成時
    context "when it creates" do
      let(:params) {
        {
          name: 'huga',
          real_name: 'hoge huga',
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
      subject { User.find(1) }

      it "is valid" do
        subject.attributes = { password: nil, password_confirmation: nil }
        subject.valid?.should be_true
      end
    end
  end

  # 日本語ユーザ名の場合
  context "with Japanese name input" do
    let(:params) {
        {
          name: 'ほげ',
          real_name: 'hoge huga',
          password: 'hogehoge',
          password_confirmation: 'hogehoge'
        }
      }

    it "is not valid" do
      subject.valid?.should be_false
    end
  end
end
