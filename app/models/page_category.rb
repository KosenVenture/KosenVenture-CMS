# encoding: utf-8

class PageCategory < ActiveRecord::Base
  # Relation ship
  has_many :pages,
    foreign_key: :category_id,
    dependent: :nullify # NULLをセット

  # Validation
  validates :name,
    presence: true,
    uniqueness: true,
    format: { with: /[a-zA-Z0-9_\-]+/ }

  # Scope
  scope :select_for_list, -> { select('id, title') }
  scope :newest_updated_order, -> { order('updated_at DESC') }

  paginates_per 10

end
