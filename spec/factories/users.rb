FactoryBot.define do
  factory :user do
    nickname              { Faker::Internet.username(specifier: 5..8) }
    email                 { Faker::Internet.free_email }
    password              { Faker::Internet.password(min_length: 6) + '9z' }
    password_confirmation { password }
    user_profile          { Faker::Lorem.sentence }
    dog_breed             { 'トイプードル' }
    dog_number            { '2' }
    dog_birthday          { Faker::Date.birthday }
    dog_profile           { Faker::Lorem.sentence }
  end
end
