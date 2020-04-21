require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  describe '投稿機能の確認' do
    let(:user) { create(:user) }
    let!(:post) { create(:post, user: user) }
    before do
      login_user user
    end
  end
  describe '新規投稿フォームとユーザーの投稿一覧ページ' do
    before do
      visit user_path(user)
    end
    context "投稿機能の確認" do
      it '投稿に成功する' do
        fill_in 'post[body]', with: Faker::Lorem.characters(number:20)
        click_button '投稿する'
      end
      it '投稿に失敗する' do
        click_button '投稿する'
        expect(current_path).to eq('/users/' + user.id.to_s)
      end
    end
  end
end
