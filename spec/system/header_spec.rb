require 'rails_helper'

RSpec.describe 'Header', type: :system do
  describe 'ヘッダーのテスト' do
    describe 'ログインしていない場合' do
      before do
        visit root_path
      end
      context 'ヘッダーの表示を確認' do
        subject { page }
        it 'タイトルが表示される' do
          is_expected.to have_content 'MCS Cafe'
        end
        it 'Homeリンクが表示される' do
          home_link = find_all('a')[1].native.inner_text
          expect(home_link).to match(/home/i)
          #is_expected.to have_content 'Home'
        end
        it 'Aboutリンクが表示される' do
          about_link = find_all('a')[2].native.inner_text
          expect(about_link).to match(/about/i)
          #is_expected.to have_content 'About'
        end
        it 'Contactリンクが表示される' do
          contact_link = find_all('a')[3].native.inner_text
          expect(contact_link).to match(/contact/i)
          #is_expected.to have_content 'Sign up'
        end
        it 'Log inリンクが表示される' do
          login_link = find_all('a')[4].native.inner_text
          expect(login_link).to match(/Log in/i)
          #is_expected.to have_content 'login'
        end
      end
      context 'ヘッダーのリンクを確認' do
        subject { current_path }
        it 'Home画面に遷移する' do
          home_link = find_all('a')[1].native.inner_text
          home_link = home_link.delete(' ')
          home_link.gsub!(/\n/, '')
          click_link home_link
          is_expected.to eq(root_path)
        end
        it 'About画面に遷移する' do
          about_link = find_all('a')[2].native.inner_text
          about_link = about_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
          click_link about_link
          is_expected.to eq('/about')
        end
        it 'Contact画面に遷移する' do
          contact_link = find_all('a')[3].native.inner_text
          contact_link = contact_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
          click_link contact_link
          is_expected.to eq('/contacts/new')
        end
        it 'ログイン画面に遷移する' do
          login_link = find_all('a')[4].native.inner_text
          login_link = login_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
          click_link login_link
          is_expected.to eq(new_user_session_path)
        end
      end
    end

    describe 'ログインしている場合' do
      let(:user) { create(:user) }
      before do
        visit new_user_session_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'Log in'
      end
      context 'ヘッダーの表示を確認' do
        subject { page }
        it 'タイトルが表示される' do
          is_expected.to have_content 'MCS Cafe'
        end
        it 'マイページリンクが表示される' do
          mypage_link = find_all('a')[1].native.inner_text
          expect(mypage_link).to match(/マイページ/i)
        end
        it 'タイムラインリンクが表示される' do
          posts_link = find_all('a')[2].native.inner_text
          expect(posts_link).to match(/タイムライン/i)
        end
        it 'チャットリンクが表示される' do
          rooms_link = find_all('a')[3].native.inner_text
          expect(rooms_link).to match(/チャット/i)
        end
        it 'お問い合わせリンクが表示される' do
          contacts_link = find_all('a')[4].native.inner_text
          expect(contacts_link).to match(/お問い合わせ/i)
        end
        it 'logoutリンクが表示される' do
          logout_link = find_all('a')[5].native.inner_text
          expect(logout_link).to match(/ログアウト/i)
        end
      end

      context 'ヘッダーのリンクを確認' do
        subject { current_path }
        it 'マイページに遷移する' do
          mypage_link = find_all('a')[1].native.inner_text
          mypage_link = mypage_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
          click_link mypage_link
          is_expected.to eq('/users/'+user.id.to_s)
        end
        it 'タイムラインに遷移する' do
          posts_link = find_all('a')[2].native.inner_text
          posts_link = posts_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
          click_link posts_link
          is_expected.to eq('/posts')
        end
        it 'チャット一覧に遷移する' do
          rooms_link = find_all('a')[3].native.inner_text
          rooms_link = rooms_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
          click_link rooms_link
          is_expected.to eq('/rooms')
        end
        it 'お問い合わせ画面に遷移する' do
          contacts_link = find_all('a')[4].native.inner_text
          contacts_link = contacts_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
          click_link contacts_link
          is_expected.to eq('/contacts/new')
        end
        it 'logoutする' do
          logout_link = find_all('a')[5].native.inner_text
          logout_link = logout_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
          click_link logout_link
        end
      end
    end

    describe '管理者がログインしている場合' do
      let(:admin) { create(:admin) }
      before do
        visit new_admin_session_path
        fill_in 'admin[email]', with: admin.email
        fill_in 'admin[password]', with: admin.password
        click_button 'Log in'
      end
      context 'ヘッダーの表示を確認' do
        subject { page }
        it 'タイトルが表示される' do
          is_expected.to have_content 'MCS Cafe 管理者'
        end
        it 'ニュース一覧リンクが表示される' do
          news_link = find_all('a')[1].native.inner_text
          expect(news_link).to match(/ニュース一覧/i)
        end
        it 'ユーザー一覧リンクが表示される' do
          user_link = find_all('a')[2].native.inner_text
          expect(user_link).to match(/ユーザー一覧/i)
        end
        it 'お問い合わせ一覧リンクが表示される' do
          contact_link = find_all('a')[3].native.inner_text
          expect(contact_link).to match(/お問い合わせ一覧/i)
        end
        it 'メニュー変更リンクが表示される' do
          menu_link = find_all('a')[4].native.inner_text
          expect(menu_link).to match(/メニュー変更/i)
        end
        it 'ログアウトリンクが表示される' do
          logout_link = find_all('a')[5].native.inner_text
          expect(logout_link).to match(/ログアウト/i)
        end
      end

      context 'ヘッダーのリンクを確認' do
        subject { current_path }
        it 'ニュース一覧に遷移する' do
          news_link = find_all('a')[1].native.inner_text
          news_link = news_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
          click_link news_link
          is_expected.to eq('/admin/news')
        end
        it 'ユーザー一覧に遷移する' do
          user_link = find_all('a')[2].native.inner_text
          user_link = user_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
          click_link user_link
          is_expected.to eq('/admin/users')
        end
        it 'お問い合わせ一覧に遷移する' do
          contact_link = find_all('a')[3].native.inner_text
          contact_link = contact_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
          click_link contact_link
          is_expected.to eq('/admin/contacts')
        end
        it 'メニュー変更画面に遷移する' do
          menu_link = find_all('a')[4].native.inner_text
          menu_link = menu_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
          click_link menu_link
          is_expected.to eq('/admin/menus')
        end
        it 'ログアウトする' do
          logout_link = find_all('a')[5].native.inner_text
          logout_link = logout_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
          click_link logout_link
        end
      end
    end
  end
end