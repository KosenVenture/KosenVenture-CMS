# encoding: utf-8

class BlogCategory < ActiveRecord::Base
  # public_activity
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_admin }

  # Relation ship
  has_many :posts,
    class_name: 'BlogPost',
    foreign_key: :category_id,
    dependent: :nullify # NULLをセット

  # Validation
  validates :name,
    presence: true,
    uniqueness: true,
    format: { with: /[a-zA-Z0-9_\-]+/ }
  validates :title,
    presence: true,
    uniqueness: true

  # Scope
  scope :select_for_list, -> { select('id, title') }
  scope :newest_updated_order, -> { order('updated_at DESC') }

  paginates_per 10
end
