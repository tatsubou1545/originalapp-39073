class Post < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :image, presence: true
  validates :category_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }

  belongs_to :user
  has_one_attached :image
end
