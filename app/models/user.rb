class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, presence: true, uniqueness: { case_sensitive: true }
  validates :dog_number, format: { with: /\A[0-9]+\z/, message: "を数字で入力してください" }
  
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
    validates :password, format: { with: VALID_PASSWORD_REGEX }, on: :create

  has_many :posts
  has_many :messages
  has_many :room_users
  has_many :rooms, through: :room_users
  has_one_attached :image
  has_many :dog_profiles
end
