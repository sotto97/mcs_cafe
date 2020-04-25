require 'rails_helper'

RSpec.describe 'Admins', type: :system do
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

  describe '管理者ユーザーのテスト' do
    let(:admin) { create(:admin) }
    let(:user) { create(:user) }
    let!(:notice) { create(:notice, user: user) }
    let!(:news) { create(:news, admin: admin) }
    before do
      visit new_admin_session_path
      fill_in 'admin[email]', with: admin.email
      fill_in 'admin[password]', with: admin.password
      click_button 'Log in'
    end
    describe '違反者通報のテスト' do
      before do
        visit admin_notices_path
      end
      context '表示の確認' do
        it '通報通達一覧と表示される' do
          visit admin_notices_path
          expect(page).to have_content('通報通達一覧')
        end
        it '通報IDが表示される' do
          expect(page).to have_content(notice.id)
          expect(page).to have_link notice.id.to_s, href: admin_notice_path(notice)
        end
        it '通報されたユーザーIDが表示される' do
          expect(page).to have_content(notice.user_id)
        end
        it '通報されたユーザー名が表示される' do
          expect(page).to have_content(notice.username)
        end
        it '通報内容が表示される' do
          expect(page).to have_content(notice.body)
        end
      end
      context '通報詳細の確認' do
        before do
          visit admin_notice_path(notice)
          expect(current_path).to eq('/admin/' + 'notices/' + notice.id.to_s)
        end
        it '通報通達詳細と表示される' do
          expect(page).to have_content('通報通達詳細')
        end
        it '通報IDが表示される' do
          expect(page).to have_content(notice.id)
        end
        it '通報されたユーザーIDが表示される' do
          expect(page).to have_content(notice.user_id)
        end
        it '通報されたユーザー名が表示される' do
          expect(page).to have_content(notice.username)
        end
        it '通報内容が表示される' do
          expect(page).to have_content(notice.body)
        end
      end
    end

    describe 'ニュース機能のテスト' do
      context 'ニュース新規投稿と一覧画面への遷移' do
        it '遷移できる' do
          visit admin_news_index_path
          expect(current_path).to eq('/admin/' + 'news')
        end
      end

      context '表示の確認' do
        before do
          visit admin_news_index_path
        end
        it 'ニュース新規投稿フォームが表示される' do
          expect(page).to have_content('ニュース新規投稿')
        end
        it 'ニュース新規投稿のタイトルフォームが表示される' do
          expect(page).to have_field 'news[title]'
        end
        it 'ニュース新規投稿の内容フォームが表示される' do
          expect(page).to have_field 'news[body]'
        end
        it 'ニュース一覧が表示される' do
          expect(page).to have_content('ニュース一覧')
        end
        it 'ニュースタイトルが表示される' do
          expect(page).to have_content(news.title)
        end
        it 'ニュース内容が表示される' do
          visit admin_news_index_path
          expect(page).to have_content (news.body)
        end
        it '投稿確認画面に遷移する' do
          fill_in 'news[title]', with: news.title
          fill_in 'news[body]', with: news.body
          click_button '投稿する'
          expect(current_path).to eq('/admin/' + 'news/' + 'confirm')
        end
      end
    end
  end
end