require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  describe 'コメント投稿' do
    context 'コメント投稿できる場合' do
      it 'コメント内容が存在すれば登録できる' do
        expect(@comment).to be_valid
      end
    end
    context 'コメント投稿できない場合' do
      it 'コメント内容が空では登録できない' do
        @comment.text ='' 
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Text can't be blank")
      end
      it 'ユーザが紐づいていないと登録できない' do
        @comment.user = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('User must exist')
      end
      it '投稿内容が紐づいていないと登録できない' do
        @comment.post = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Post must exist')
      end
    end
  end
end
