FactoryBot.define do
  factory :message do
    content {Faker::Lorem.sentence}
    association :user
    association :room

    after(:build) do |message|
      message.image.attach(io: File.open('app/assets/images/Logo_black.png'), filename: 'Logo_black.png')
    end
  end
end
