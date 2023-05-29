class Post < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category

  validates :title, presence: true, length: { maximum: 32 }
  validates :content, presence: true
  validates :image, presence: true
  validates :category_id, presence: true, numericality: { other_than: 1, message: "を選択してください" }

  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end
