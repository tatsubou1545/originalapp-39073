FactoryBot.define do
  factory :post do
    title              { Faker::Lorem.characters(number: 32)}
    content            { Faker::Lorem.sentence }
    category_id        { Category.find_by(name: '旅行').id }
    association :user

    after(:build) do |post|
      post.image.attach(io: File.open('app/assets/images/picture.png'), filename: 'picture.png')
    end
  end
end
