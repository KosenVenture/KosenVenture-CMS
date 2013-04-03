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
end
