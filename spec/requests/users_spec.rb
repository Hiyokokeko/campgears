require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { create(:user) }
  let(:admin_user) { create(:admin_user) }
  let(:other_user) { create(:user) }

  describe '#index' do
    context 'ゲストユーザーとして' do
      it 'アクセスできない' do
        get users_path
        expect(response).to redirect_to login_path
      end
    end
    context 'ログインユーザーとして' do
      it 'アクセスできない' do
        sign_in user
        get users_path
        expect(response).to redirect_to root_path
      end
    end
    context 'adminユーザーとして' do
      it '正常にアクセスできる' do
        sign_in admin_user
        get users_path
        expect(response).to be_successful
      end
    end
  end

  describe '#show' do
    context 'ゲストユーザーとして' do
      it 'アクセスできる' do
        get user_path(user)
        expect(response).to be_successful
      end
    end
    context 'ログインユーザーとして' do
      it 'アクセスできる' do
        sign_in user
        get user_path(user)
        expect(response).to be_successful
      end
    end
  end

  describe '#new' do
    it 'アクセスできる' do
      get new_user_path
      expect(response).to be_successful
    end
  end

  describe '#edit' do
    context 'ゲストユーザーとして' do
      it 'アクセスできない' do
        get edit_user_path(user)
        expect(response).to redirect_to login_path
      end
    end
    context 'ログイン済みの別ユーザーとして' do
      it 'アクセスできない' do
        sign_in other_user
        get edit_user_path(user)
        expect(response).to redirect_to root_path
      end
    end
    context 'currentユーザーとして' do
      it 'アクセスできる' do
        sign_in user
        get edit_user_path(user)
        expect(response).to be_successful
      end
    end
  end

  describe '#update' do
    context 'ゲストユーザーとして' do
      it '更新できない' do
        user_params = attributes_for(:user, name: 'NewName')
        patch user_path(user), params: { id: user.id, user: user_params }
        expect(user.reload.name).to_not eq 'NewName'
      end
    end
    context 'ログイン済みの別ユーザーとして' do
      it '更新できない' do
        sign_in other_user
        user_params = attributes_for(:user, name: 'NewName')
        patch user_path(user), params: { id: user.id, user: user_params }
        expect(user.reload.name).to_not eq 'NewName'
      end
    end
    context 'currentユーザーとして' do
      it '更新できる' do
        sign_in user
        user_params = attributes_for(:user, name: 'NewName')
        patch user_path(user), params: { id: user.id, user: user_params }
        expect(user.reload.name).to eq 'NewName'
      end
    end
  end
end
