class SiteConfig < ActiveRecord::Base
  # public_activity
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_admin }

  attr_accessible :description, :keywords, :title

  # Validation
  validates :keywords,
    length: { maximum: 255 }
end
