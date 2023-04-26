FactoryBot.define do
  factory :dog_profile do
    dog_breed             { 'トイプードル' }
    dog_birthday          { Faker::Date.birthday }
    dog_profile           { Faker::Lorem.sentence }
    association :user

    after(:build) do |message|
      message.image.attach(io: File.open('app/assets/images/Logo_black.png'), filename: 'Logo_black.png')
    end
  end
end
