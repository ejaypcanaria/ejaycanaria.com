class Blog < ActiveRecord::Base

  # Callbacks
  before_validation :generate_permalink
  before_save :titleize_title

  # Validations
  validates :title, presence: true
  validates :permalink, length: {maximum: 500}, uniqueness: true
  validates :status, presence: true

  # Associations
  belongs_to :author, class_name: "User", foreign_key: "user_id"

  has_many :model_tags, as: :taggable
  has_many :tags, through: :model_tags

  accepts_nested_attributes_for :tags

  private
  def titleize_title
    self.title = self.title.titleize
  end

  def generate_permalink
    count = Blog.where(title: self.title.titleize).count
    post_append = "-#{count+1}" if count > 1
    temp_permalink = "#{self.title.parameterize}#{post_append}"

    self.permalink = determine_unique_permalink(temp_permalink, count)
  end

  def determine_unique_permalink(permalink, last_count)
    existing_permalink = Blog.where(permalink: permalink).pluck(:permalink).first
    if existing_permalink
      "#{self.title.parameterize}-#{generate_permalink_appender(existing_permalink)}"
    else
      permalink
    end
  end

  def generate_permalink_appender(permalink)
    count = Integer(permalink.last) rescue nil
    if count
      count + 1
    else
      2
    end
  end

end
