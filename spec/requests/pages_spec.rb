require 'rails_helper'

RSpec.describe 'Pages', type: :request do
  let(:user) { create(:user) }
  let(:page) { create(:page, user: user) }
  let(:other_user) { create(:user) }

  describe 'いいねランキングページ' do
    context 'ゲストユーザーとして' do
      it 'アクセスできる' do
        get '/rank'
        expect(response).to be_successful
      end
    end
    context 'ログインユーザーとして' do
      it 'アクセスできる' do
        sign_in user
        get '/rank'
        expect(response).to be_successful
      end
    end
  end

  describe '#index' do
    context 'ゲストユーザーとして' do
      it 'アクセスできる' do
        get pages_path
        expect(response).to be_successful
      end
    end
    context 'ログインユーザーとして' do
      it 'アクセスできる' do
        sign_in user
        get pages_path
        expect(response).to be_successful
      end
    end
  end

  describe '#show' do
    context 'ゲストユーザーとして' do
      it 'アクセスできる' do
        get page_path(page)
        expect(response).to be_successful
      end
    end
    context 'ログインユーザーとして' do
      it 'アクセスできる' do
        sign_in user
        get page_path(page)
        expect(response).to be_successful
      end
    end
  end

  describe '#new' do
    context 'ゲストユーザーとして' do
      it 'アクセスできない' do
        get new_page_path
        expect(response).to redirect_to login_path
      end
    end
    context 'ログインユーザーとして' do
      it 'アクセスできる' do
        sign_in user
        get new_page_path
        expect(response).to be_successful
      end
    end
  end

  describe '#create' do
    context 'ゲストユーザーとして' do
      it '新規投稿できない' do
        get new_page_path
        expect(response).to redirect_to login_path
      end
    end
    context 'ログインユーザーとして' do
      it '新規投稿できる' do
        page_params = attributes_for(:page)
        sign_in user
        expect do
          post pages_path, params: { page: page_params }
        end.to change(user.pages, :count).by(1)
      end
    end
  end

  describe '#edit' do
    context 'ゲストユーザーとして' do
      it 'アクセスできない' do
        get edit_page_path(page)
        expect(response).to redirect_to login_path
      end
    end
    context 'ログイン済みの別ユーザーとして' do
      it 'アクセスできない' do
        sign_in other_user
        get edit_page_path(page)
        expect(response).to redirect_to root_path
      end
    end
    context 'currentユーザーとして' do
      it 'アクセスできる' do
        sign_in user
        get edit_page_path(page)
        expect(response).to be_successful
      end
    end
  end

  describe '#update' do
    context 'ゲストユーザーとして' do
      it '更新できない' do
        page_params = attributes_for(:page, title: 'NewTitle')
        patch page_path(page), params: { id: page.id, page: page_params }
        expect(page.reload.title).to eq 'My gear'
      end
    end
    context 'ログイン済みの別ユーザーとして' do
      it '更新できない' do
        page_params = attributes_for(:page, title: 'NewTitle')
        sign_in other_user
        patch page_path(page), params: { id: page.id, page: page_params }
        expect(page.reload.title).to eq 'My gear'
      end
    end
    context 'currentユーザーとして' do
      it '更新できる' do
        page_params = attributes_for(:page, title: 'NewTitle')
        sign_in user
        patch page_path(page), params: { id: page.id, page: page_params }
        expect(page.reload.title).to eq 'NewTitle'
      end
    end
  end

  describe '#update' do
    context 'ゲストユーザーとして' do
      it '更新できない' do
        page_params = attributes_for(:page, title: 'NewTitle')
        patch page_path(page), params: { id: page.id, page: page_params }
        expect(page.reload.title).to eq 'My gear'
      end
    end
    context 'ログイン済みの別ユーザーとして' do
      it '更新できない' do
        page_params = attributes_for(:page, title: 'NewTitle')
        sign_in other_user
        patch page_path(page), params: { id: page.id, page: page_params }
        expect(page.reload.title).to eq 'My gear'
      end
    end
    context 'currentユーザーとして' do
      it '更新できる' do
        page_params = attributes_for(:page, title: 'NewTitle')
        sign_in user
        patch page_path(page), params: { id: page.id, page: page_params }
        expect(page.reload.title).to eq 'NewTitle'
      end
    end
  end
end
