require 'rails_helper'

RSpec.describe 'Access', type: :system do
  describe 'ユーザー権限のテスト'  do
    let!(:user) { create(:user) }
    let!(:post) { create(:post, user: user) }
    describe 'ログインしていない場合' do
      context '投稿関連のURLにアクセス' do
        it 'タイムラインに遷移できない' do
          visit posts_path
          expect(current_path).to eq('/users/sign_in')
        end
        it '投稿詳細画面に遷移できない' do
          visit post_path(post.id)
          expect(current_path).to eq('/users/sign_in')
        end
      end
    end
    describe 'ログインしていない場合にユーザー関連のURLにアクセス' do
      context 'ユーザー関連のURLにアクセス' do
        it '編集画面に遷移できない' do
          visit edit_user_path(user.id)
          expect(current_path).to eq('/users/sign_in')
        end
        it '詳細画面に遷移できない' do
          visit user_path(user.id)
          expect(current_path).to eq('/users/sign_in')
        end
      end
    end
  end

  describe '管理者権限のテスト'  do
    let!(:admin) { create(:admin) }
    let!(:user) { create(:user) }
    let!(:post) { create(:post, user: user) }
    describe 'ログインしていない場合にユーザー関連のURLにアクセス' do
      context 'ユーザー関連のURLにアクセス' do
        it '編集画面に遷移できない' do
          visit admin_users_path
          expect(current_path).to eq('/admins/sign_in')
        end
        it '詳細画面に遷移できない' do
          visit admin_user_path(user.id)
          expect(current_path).to eq('/admins/sign_in')
        end
      end
    end
  end
end