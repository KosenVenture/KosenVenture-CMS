# encoding: utf-8

class BlogPost < ActiveRecord::Base
  # Relation ship
  belongs_to :author,
    class_name: 'User',
    foreign_key: :author_id
  #belongs_to :category,
  #  class_name: 'BlogCategory',
  #  foreign_key: :category_id

  # Validation
  # 必須項目
  validates :author_id, :title,
    presence: true

  # 関連先の存在チェック
  validate :author_exists?
  #validate :category_exists?

  # Scopes
  scope :published, -> { where(published: true) }
  scope :select_for_index, -> { select(%w(id name title published category_id author_id updated_at).join(',')) }
  scope :select_for_list, -> { select('id, title') }
  scope :newest_updated_order, -> { order('updated_at DESC') }


  private

  def author_exists?
    errors.add(:author_id, 'はDBに存在しません．') unless User.exists?(author_id)
  end

  def category_exists?
    # 空欄は許可
    # 空欄じゃ無いときカテゴリが存在するかチェック
    #errors.add(:category_id, 'はDBに存在しません．') unless category_id.nil? || BlogCategory.exists?(category_id)
  end
end
