class DogProfile < ApplicationRecord
  validates :dog_breed, presence: true

  belongs_to :user
  has_one_attached :image

  def dog_age
    today = Date.today
    age = today.year - dog_birthday.year
    if today.month < dog_birthday.month || (today.month == dog_birthday.month && today.day < dog_birthday.day)
      age -= 1 # まだ誕生日を迎えていない
    end
    age
  end
end
