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

    self.permalink = unique_permalink(temp_permalink, count)
  end

  def unique_permalink(permalink, last_count)
    found = Blog.where(permalink: permalink).pluck(:permalink).size > 0
    if found
      "#{self.title.parameterize}-#{last_count + 1}"
    else
      permalink
    end
  end

end
