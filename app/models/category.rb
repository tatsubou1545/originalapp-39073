class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '旅行' },
    { id: 3, name: '病院' },
    { id: 4, name: 'ドッグラン' },
    { id: 5, name: '散歩' },
    { id: 6, name: 'ご飯' },
    { id: 7, name: 'おもちゃ' },
    { id: 8, name: 'パピー' },
    { id: 9, name: 'トリミング' },
    { id: 10, name: 'その他' }
  ]

  include ActiveHash::Associations
  has_many :posts

  end