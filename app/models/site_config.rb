class SiteConfig < ActiveRecord::Base
  attr_accessible :description, :keywords, :title

  # Validation
  validates :keywords,
    length: { maximum: 255 }
end
