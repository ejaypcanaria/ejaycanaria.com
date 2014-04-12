class Blog < ActiveRecord::Base

  # Callbacks
  before_validation :generate_permalink

  # Validations
  validates :title, presence: true
  validates :permalink, presence: true, length: {maximum: 500}


  private

  def generate_permalink
    self.permalink = self.title.parameterize
  end

end
