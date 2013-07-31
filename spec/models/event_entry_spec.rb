require 'spec_helper'

describe EventEntry do
  # 必須項目検証
  [
    :name_kanji,
    :name_kana,
    :email,
    :sexial,
    :nct,
    :grade,
    :major,
    :appeal,
    :skype
  ].each do |sym|
    it { should validate_presence_of(sym) }
  end

  # 文字数制限検証
  it { should ensure_length_of(:name_kanji).is_at_most(50) }
  it { should ensure_length_of(:name_kana).is_at_most(50) }
  it { should ensure_length_of(:email).is_at_most(256) }
  it { should ensure_length_of(:facebook).is_at_most(256) }
  it { should ensure_length_of(:twitter).is_at_most(50) }
  it { should ensure_length_of(:github).is_at_most(50) }

  it { should allow_value("hoge@hoge.co.jp").for(:email) }
  it { should allow_value("a-b_c+2.3@hoge.com").for(:email) }
  it { should_not allow_value("huga.@hoge.com").for(:email) }
  it { should_not allow_value("a--b---v.@huga.com").for(:email) }
  it { should_not allow_value("12345.g..g@hge.com").for(:email) }
  it { should_not allow_value("@hoge.com").for(:email) }
end
