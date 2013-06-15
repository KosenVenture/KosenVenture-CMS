class User < ActiveRecord::Base
  has_secure_password

  ROLES = %w(admin manager blogger)

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
  validates :role,
    presence: true

  # Scope
  scope :select_for_list, -> { select('id, real_name, role') }
  scope :newest_updated_order, -> { order('updated_at DESC') }

  paginates_per 10

  def admin?
    role == 'admin'
  end

  def manager?
    role == 'manager'
  end

  def blogger?
    role == 'blogger'
  end
end
