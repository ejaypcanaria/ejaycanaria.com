class Blog < ActiveRecord::Base

  # Callbacks
  before_validation :generate_permalink

  # Validations
  validates :title, presence: true
  validates :permalink, presence: true, length: {maximum: 500}
  validates :status, presence: true

  # Associations
  belongs_to :user

  private

  def generate_permalink
    self.permalink = self.title.parameterize
  end

end
