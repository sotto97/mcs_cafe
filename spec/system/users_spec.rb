require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'ユーザー認証のテスト' do
    describe 'ユーザー新規登録' do
      before do
        visit new_user_registration_path
      end
      context '新規登録画面に遷移' do
        it '新規登録に成功する' do
          fill_in 'user[username]', with: Faker::Internet.username(specifier: 5)
          fill_in 'user[email]', with: Faker::Internet.email
          fill_in 'user[password]', with: 'password'
          fill_in 'user[password_confirmation]', with: 'password'
          click_button 'Sign up'
        end
        it '新規登録に失敗する' do
          fill_in 'user[username]', with: ''
          fill_in 'user[email]', with: ''
          fill_in 'user[password]', with: ''
          fill_in 'user[password_confirmation]', with: ''
          click_button 'Sign up'
        end
      end
    end
    describe 'ユーザーログイン' do
      let(:user) { create(:user) }
      before do
        user
        visit new_user_session_path
      end
      context 'ログイン画面に遷移' do
        it 'ログインに成功する' do
          fill_in 'user[email]', with: user.email
          fill_in 'user[password]', with: user.password
          click_button 'Log in'
        end
        it 'ログインに失敗する' do
          fill_in 'user[email]', with: ''
          fill_in 'user[password]', with: ''
          click_button 'Log in'
          expect(current_path).to eq(new_user_session_path)
        end
      end
    end
  end

  describe 'ユーザーのテスト' do
    let(:user) { create(:user) }
    let!(:test_user2) { create(:user) }
    let!(:post) { create(:post, user: user) }
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'Log in'
      visit user_path(user)
    end
    describe 'サイドバーのテスト' do
      context '表示の確認' do
        it '情報編集すると表示される' do
          expect(page).to have_content('情報編集する')
        end
        it '画像が表示される' do
          expect(page).to have_css('img.profile_image')
        end
        it '名前が表示される' do
          expect(page).to have_content(user.username)
        end
        it '自己紹介が表示される' do
          expect(page).to have_content(user.introduction)
        end
      end
    end

    describe '編集のテスト' do
      context '自分の編集画面への遷移' do
        it '遷移できる' do
          visit edit_user_path(user)
          expect(current_path).to eq('/users/' + user.id.to_s + '/edit')
        end
      end
      context '他人の編集画面への遷移' do
        it '遷移できない' do
          visit edit_user_path(test_user2)
          expect(current_path).to eq('/users/' + user.id.to_s)
        end
      end

      context '表示の確認' do
        before do
          visit edit_user_path(user)
        end
        it 'メールアドレスフォームに自分の名前が表示される' do
          expect(page).to have_field 'user[email]', with: user.email
        end
        it '名前編集フォームに自分の名前が表示される' do
          expect(page).to have_field 'user[username]', with: user.username
        end
        it '画像編集フォームが表示される' do
          expect(page).to have_field 'user[profile_image]'
        end
        it '自己紹介編集フォームに自分の自己紹介が表示される' do
          expect(page).to have_field 'user[introduction]', with: user.introduction
        end
        it '編集に成功する' do
          click_button '更新する'
          expect(current_path).to eq('/users/' + user.id.to_s)
        end
        it '編集に失敗する' do
          fill_in 'user[username]', with: ''
          click_button '更新する'
          expect(current_path).to eq('/users/' + user.id.to_s)
        end
      end
    end

    describe '詳細画面のテスト' do
      before do
        visit user_path(user)
      end
      context '表示の確認' do
        it '投稿一覧のユーザーの画像のリンク先が正しい' do
          expect(page).to have_link '', href: user_path(user)
        end
        it '投稿一覧のbodyのリンク先が正しい' do
          expect(page).to have_link post.body, href: post_path(post)
        end
        it '投稿一覧にopinionが表示される' do
          expect(page).to have_content(post.body)
        end
      end
    end
  end
end
