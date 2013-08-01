require 'spec_helper'

describe Contact do
  # 必須項目検証
  [
    :name_kanji,
    :name_kana,
    :email,
  ].each do |sym|
    it { should validate_presence_of(sym) }
  end

  # 文字数制限検証
  it { should ensure_length_of(:name_kanji).is_at_most(50) }
  it { should ensure_length_of(:name_kana).is_at_most(50) }
  it { should ensure_length_of(:email).is_at_most(256) }
  it { should ensure_length_of(:affiliation).is_at_most(100) }
  it { should ensure_length_of(:body).is_at_least(10).is_at_most(3000) }

  it { should allow_value("hoge@hoge.co.jp").for(:email) }
  it { should allow_value("a-b_c+2.3@hoge.com").for(:email) }
  it { should_not allow_value("huga.@hoge.com").for(:email) }
  it { should_not allow_value("a--b---v.@huga.com").for(:email) }
  it { should_not allow_value("12345.g..g@hge.com").for(:email) }
  it { should_not allow_value("@hoge.com").for(:email) }

  context "with normal input" do
    subject { Contact.new(params) }
    let(:params) {{
      name_kanji: "高専　太郎",
      name_kana: "こうせん　たろう",
      email: "kosen.tarou@kosen-venture.com",
      body: "こんにちは。はじめまして。"
    }}

    it "is valid" do
      expect(subject.valid?).to be_true
    end
  end
end
