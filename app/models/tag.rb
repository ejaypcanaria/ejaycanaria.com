class Tag < ActiveRecord::Base

  # Validations
  validates :name, presence: true, uniqueness: true

  # Associations
  has_many :model_tags
  has_many :blogs, through: :model_tags, source: :taggable, source_type: 'Blog'

end
