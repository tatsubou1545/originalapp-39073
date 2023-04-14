class Post < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category

  validates :title, presence: true, length: { maximum: 32 }
  validates :content, presence: true
  validates :image, presence: true
  validates :category_id, presence: true, numericality: { other_than: 1, message: "を選択してください" }

  belongs_to :user
  has_one_attached :image
end
