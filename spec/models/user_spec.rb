require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
    @user_update = FactoryBot.create(:user)
  end

  describe 'ユーザー情報更新' do
    it '画像添付でもユーザー情報が更新される' do
      image = fixture_file_upload('app/assets/images/Logo_black.png', 'image/png')
      set_params={
        nickname: 'new_nickname',
        email: 'new_email@example.com',
        user_profile: 'new_profile',
        image: image
      }
      @user_update.update(set_params)
      expect(@user_update.nickname).to eq('new_nickname')
      expect(@user_update.email).to eq('new_email@example.com')
      expect(@user_update.user_profile).to eq('new_profile')
      expect(@user_update.image).to be_attached
    end
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it 'ニックネーム、email、password、password_confirmation、ユーザープロフィールが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'ユーザープロフィールが空でも登録できる' do
        user_profile = ''
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it 'ニックネームが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'emailが重複で登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailが@を含まず登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordは5文字以下では登録できない' do
        @user.password = '123ab'
        @user.password_confirmation = '123ab'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordは半角英字だけでは登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'passwordは数字だけでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'passwordは英字のみでは登録できない' do
        @user.password = 'AbCdEf'
        @user.password_confirmation = 'AbCdEf'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'passwordは全角文字を含むと登録できない' do
        @user.password = 'パスワード'
        @user.password_confirmation = 'パスワード'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'passwordとpassword_confirmationが一致していないと登録できない' do
        @user.password = '123abc'
        @user.password_confirmation = '123abcd'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'ニックネームが重複していると登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, nickname: @user.nickname)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Nickname has already been taken")
      end
    end
  end
end
