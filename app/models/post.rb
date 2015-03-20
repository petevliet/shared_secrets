class Post < ActiveRecord::Base

  validates :link, url: true
  belongs_to :user, dependent: :destroy
  has_many :comments
end
