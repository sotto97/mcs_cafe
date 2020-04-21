require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe '管理者ユーザー認証のテスト' do
    describe '管理者ログイン' do
      let(:admin) { create(:admin) }
      before do
        admin
        visit new_admin_session_path
      end
      context 'ログイン画面に遷移' do
        it 'ログインに成功する' do
          fill_in 'admin[email]', with: admin.email
          fill_in 'admin[password]', with: admin.password
          click_button 'Log in'
          # expect(page).to have_content 'successfully'
        end

        it 'ログインに失敗する' do
          fill_in 'admin[email]', with: ''
          fill_in 'admin[password]', with: ''
          click_button 'Log in'
          expect(current_path).to eq(new_admin_session_path)
        end
      end
    end
  end
end