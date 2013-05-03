# encoding: utf-8

class EventEntry
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  # フィールド
  attr_accessor :name_kanji, :name_kana, :email, :sexial, :birthday,
    :nct, :grade, :major,
    :twitter, :github, :facebook,
    :appeal, :myproduct,
    :question1,
    :mail_ok

  # 必須項目
  validates :name_kanji, :name_kana, :email, :sexial, :birthday,
    :nct, :grade, :major, :appeal,
    presence: true

  # 文字量制限
  validates :name_kanji, :name_kana,
    length: { maximum: 50 }
  validates :email, :facebook
    length: { maximum: 256 }
  validates :twitter, :github,
    maximum: 50

  # メールアドレスの不正な形式をはじく
  validate :email_valid?

  NCT_NAMES = [
    "函館工業高等専門学校",
    "苫小牧工業高等専門学校",
    "釧路工業高等専門学校",
    "旭川工業高等専門学校",
    "八戸工業高等専門学校",
    "一関工業高等専門学校",
    "仙台高等専門学校",
    "秋田工業高等専門学校",
    "鶴岡工業高等専門学校",
    "福島工業高等専門学校",
    "茨城工業高等専門学校",
    "小山工業高等専門学校",
    "群馬工業高等専門学校",
    "木更津工業高等専門学校",
    "東京工業高等専門学校",
    "東京都立産業技術高等専門学校",
    "サレジオ工業高等専門学校",
    "長岡工業高等専門学校",
    "富山高等専門学校",
    "石川工業高等専門学校",
    "金沢工業高等専門学校",
    "福井工業高等専門学校",
    "長野工業高等専門学校",
    "岐阜工業高等専門学校",
    "沼津工業高等専門学校",
    "豊田工業高等専門学校",
    "鳥羽商船高等専門学校",
    "鈴鹿工業高等専門学校",
    "近畿大学工業高等専門学校",
    "舞鶴工業高等専門学校",
    "大阪府立大学工業高等専門学校",
    "明石工業高等専門学校",
    "神戸市立工業高等専門学校",
    "奈良工業高等専門学校",
    "和歌山工業高等専門学校",
    "米子工業高等専門学校",
    "松江工業高等専門学校",
    "津山工業高等専門学校",
    "広島商船高等専門学校",
    "呉工業高等専門学校",
    "徳山工業高等専門学校",
    "宇部工業高等専門学校",
    "大島商船高等専門学校",
    "阿南工業高等専門学校",
    "香川高等専門学校",
    "新居浜工業高等専門学校",
    "弓削商船高等専門学校",
    "高知工業高等専門学校",
    "北九州工業高等専門学校",
    "久留米工業高等専門学校",
    "有明工業高等専門学校",
    "佐世保工業高等専門学校",
    "熊本高等専門学校",
    "大分工業高等専門学校",
    "都城工業高等専門学校",
    "鹿児島工業高等専門学校",
    "沖縄工業高等専門学校"
  ]

  GRADES = [
    "本科1年生",
    "本科2年生",
    "本科3年生",
    "本科4年生",
    "本科5年生",
    "専攻科1年生",
    "専攻科2年生"
  ]

  QUESTION1 = [
    "友人・先輩に勧められたから",
    "Twitterのツイートを見て知った",
    "Facebookの記事を見て知った",
    "その他"
  ]

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
