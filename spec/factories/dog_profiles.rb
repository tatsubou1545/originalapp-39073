FactoryBot.define do
  factory :dog_profile do
    dog_breed             { 'トイプードル' }
    dog_birthday          { Faker::Date.birthday }
    dog_profile           { Faker::Lorem.sentence }
  end
end
