class User < ActiveRecord::Base
  has_secure_password

  # Relation ship
  has_many :pages,
    foreign_key: :author_id,
    dependent: :nullify

  # Validation
  validates :name,
    presence: true,
    uniqueness: true,
    format: { with: /[a-zA-Z0-9_\-]+/ }
  validates :password, presence: { on: :create }

  # Scope
  scope :select_for_list, -> { select('id, real_name') }
end
