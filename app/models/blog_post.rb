# encoding: utf-8

class BlogPost < ActiveRecord::Base
  # public_activity
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_admin }

  # Relation ship
  belongs_to :author,
    class_name: 'User',
    foreign_key: :author_id
  belongs_to :category,
    class_name: 'BlogCategory',
    foreign_key: :category_id

  # Validation
  # 必須項目
  validates :author_id, :title,
    presence: true

  # 関連先の存在チェック
  validate :author_exists?
  validate :category_exists?

  # Scopes
  scope :publishing, -> { where("published_at <= ?", Time.now).where(published: true).order('published_at DESC') }
  scope :select_for_index, -> { select(%w(id title published category_id author_id updated_at published_at).join(',')) }
  scope :select_for_list, -> { select('id, title') }
  scope :newest_updated_order, -> { order('updated_at DESC') }
  scope :newest_published_order, -> { order('published_at DESC') }
  scope :group_by_category,
    -> { select('blog_categories.name, blog_categories.title, COUNT(blog_posts.title) as cnt').group('category_id').joins(:category).order('cnt DESC') }

  # 次の古い記事
  def next
    BlogPost.publishing.where("published_at < ?", self.published_at).first
  end

  # 前の新しい記事
  def prev
    BlogPost.publishing.where("published_at > ?", self.published_at).last
  end

  # 月別の公開された記事
  def self.monthly
    self.publishing.select('published_at').group_by{|i| i.published_at.beginning_of_month }
  end

  paginates_per 10

  private

  def author_exists?
    errors.add(:author_id, 'はDBに存在しません．') unless User.exists?(self.author_id)
  end

  def category_exists?
    # 空欄は許可
    # 空欄じゃ無いときカテゴリが存在するかチェック
    errors.add(:category_id, 'はDBに存在しません．') unless self.category_id.nil? || BlogCategory.exists?(self.category_id)
  end
end
