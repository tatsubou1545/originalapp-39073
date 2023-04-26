require 'rails_helper'

RSpec.describe DogProfile, type: :model do
  before do
    @dog_profile = FactoryBot.build(:dog_profile)
  end

  describe '飼犬情報登録' do
    context '新規登録できる場合' do
      it "犬種、生年月日、プロフィール、画像が存在すれば作成できる" do 
        expect(@dog_profile).to be_valid
      end
      it "犬種が存在すれば作成できる" do 
        @dog_profile.dog_birthday = ''
        @dog_profile.dog_profile = ''
        @dog_profile.image = nil
        expect(@dog_profile).to be_valid
      end
    end
    context '新規登録できない場合' do
      it "犬種が空では作成できない" do
        @dog_profile.dog_breed  = ''
        @dog_profile.valid?
        expect(@dog_profile.errors.full_messages).to include("Dog breed can't be blank")
      end
      it 'userが紐付いていないと保存できない' do
        @dog_profile.user = nil
        @dog_profile.valid?
        expect(@dog_profile.errors.full_messages).to include('User must exist')
      end
    end
  end
end
