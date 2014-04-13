class Blog < ActiveRecord::Base

  # Callbacks
  before_validation :generate_permalink

  # Validations
  validates :title, presence: true
  validates :permalink, length: {maximum: 500}, uniqueness: true
  validates :status, presence: true

  # Associations
  belongs_to :author, class_name: "User", foreign_key: "user_id"

  private

  def generate_permalink
    self.permalink = self.title.parameterize
  end

end
