# encoding: utf-8

class Page < ActiveRecord::Base
  # public_activity
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_admin }

  # 最大の深さ
  MAX_DEPTH = 10
  before_validation :set_path, :set_depth

  # Relation ship
  belongs_to :author,
    class_name: 'User',
    foreign_key: :author_id

  # ページのツリー構造
  # 親ページ
  belongs_to :parent,
    class_name: 'Page',
    foreign_key: :parent_id
  # 子ページ
  has_many :children,
    class_name: 'Page',
    foreign_key: :parent_id


  # Validation
  # 必須項目
  validates :author_id,
    presence: true

  validates :name,
    presence: true,
    format: { with: /[a-zA-Z0-9_\-]+/ }

  validates :path,
    uniqueness: true

  validates :keywords,
    length: { maximum: 255 }

  validates :priority,
    presence: true,
    numericality: {
      greater_than_or_equal_to: 0.1,
      less_than_or_equal_to: 1.0
    }

  # 関連先の存在チェック
  validate :author_exists?
  validate :parent_check
  validate :uniq_path?

  # Scopes
  scope :published, -> { where(published: true).where('published_at <= ?', Time.now) }
  scope :select_for_index, -> { select(%w(id name title published author_id parent_id depth priority updated_at path).join(',')) }
  scope :newest_updated_order, -> { order('updated_at DESC') }
  scope :priority_order, -> { order('priority DESC') }
  scope :for_list, -> { select('id, title, parent_id, depth, path').order('path ASC') }

  paginates_per 10

  # ページのパスを返す
  def trace_path
    return nil if trace_depth.nil?
    # 親ページがある場合は再帰して取得
    (self.parent ? self.parent.trace_path : '') + '/' + self.name.to_s
  end

  # ページの深さを返す
  def trace_depth
    count = 0
    p = self
    while p = p.parent do
      count += 1
      if count >= MAX_DEPTH
        errors.add(:parent, "これ以上階層を深くできません。（#{MAX_DEPTH}以内）")
        return nil
      end
    end

    return count
  end

  # 選択ボックスでツリー状に表示する
  def tree_title
    "#{self.depth.times.map{'　'}.join}■#{title} (#{self.path})"
  end

  private

  def author_exists?
    errors.add(:author_id, 'はDBに存在しません．') unless User.exists?(author_id)
  end


  def parent_check
    unless parent_id.nil?
      # 親ページが存在するかチェック
      # parent_id無しは許可（親無し）
      errors.add(:parent_id, 'ページはDBに存在しません．') unless Page.exists?(parent_id)
      # 自分自身を親にできない
      errors.add(:parent_id, 'このページ自身を親にすることはできません．') if self.id == parent_id
    end
  end

  def uniq_path?
    errors.add(:parent_id, '同じ階層に同名のページが存在します．') if Page.where(['id != ?', self.id]).exists?(path: self.trace_path)
  end

  def set_path
    self.path = self.trace_path
  end

  def set_depth
    self.depth = self.trace_depth
  end
end
