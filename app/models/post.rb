class Post < ActiveRecord::Base

  validates :link, url: true
  belongs_to :user
  has_many :comments
end
