# encoding: utf-8

class Contact
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  # フィールド
  attr_accessor :name_kanji, :name_kana, :email, :affiliation, :body

  # 必須項目
  validates :name_kanji, :name_kana, :email,
    presence: true

  # 文字量制限
  validates :name_kanji, :name_kana,
    length: { maximum: 50 }
  validates :email,
    length: { maximum: 256 }
  validates :affiliation,
    length: { maximum: 100 }
  validates :body,
    length: { minimum: 10, maximum: 3000 }

  # メールアドレスの不正な形式をはじく
  validate :email_valid?



  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value) rescue nil
    end
  end

  def persisted? ; false ; end

  private

  def email_valid?
    unless email =~ /^([^@\s]+)[^.]@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i && email !~ /[.]{2}/
      errors.add(:email, 'は不正な形式のメールアドレスです。')
    end
  end
end
