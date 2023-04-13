require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @post = FactoryBot.build(:post)
  end

  describe '新規投稿' do
    context '新規投稿できる場合' do
      it 'タイトル、説明文、カテゴリー、画像が存在すれば登録できる' do
        expect(@post).to be_valid
      end
    end
    context '新規投稿できない場合' do
      it 'タイトルが空では登録できない' do
        @post.title ='' 
        @post.valid?
        expect(@post.errors.full_messages).to include("Title can't be blank")
      end
      it '説明文が空では登録できない' do
        @post.content = ''
        @post.valid?
        expect(@post.errors.full_messages).to include("Content can't be blank")
      end
      it 'カテゴリーが未選択では登録できない' do
        @post.category_id = '1'
        @post.valid?
        expect(@post.errors.full_messages).to include("Category を選択してください")
      end
      it '画像が未選択では登録できない' do
        @post.image = nil
        @post.valid?
        expect(@post.errors.full_messages).to include("Image can't be blank")
      end
      it 'ユーザが紐づいていないと登録できない' do
        @post.user = nil
        @post.valid?
        expect(@post.errors.full_messages).to include('User must exist')
      end
    end
  end
end
