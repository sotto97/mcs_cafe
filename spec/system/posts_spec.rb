require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  describe '投稿機能の確認' do
    let(:user) { create(:user) }
    let!(:post) { create(:post, user: user) }
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'Log in'
    end
    describe '新規投稿フォームとユーザーの投稿一覧ページ' do
      context '新規投稿フォームとユーザーの投稿一覧ページへの遷移' do
        it '遷移できる' do
          visit user_path(user)
          expect(current_path).to eq '/users/' + user.id.to_s
        end
      end
      context "投稿機能の確認" do
        before do
          visit user_path(user)
        end
        it '投稿に成功する' do
          fill_in 'body', with: Faker::Lorem.characters(number:20)
          click_button '投稿する'
          expect(current_path).to eq '/users/' + user.id.to_s
        end
        it '投稿に失敗する' do
          click_button '投稿する'
          expect(current_path).to eq '/users/' + user.id.to_s
        end
      end
    end
  end
end
