require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  # 名前が空欄で登録できない→名前を空欄で登録したらfalse
  # バリデーションしていない状態で失敗→設定したら成功
  # 登録できるかできないか 登録できたら失敗
  # エラーメッセージがなければ失敗

  describe 'バリデーションのテスト' do
    let(:user) { build(:user) }
    subject { test_user.valid? }
    context 'first_nameカラム' do
      let(:test_user) { user }
      it '空欄でないこと' do
        test_user.first_name = ''
        is_expected.to eq false;
      end
    end

    context 'last_nameカラム' do
      let(:test_user) { user }
      it '空欄でないこと' do
        test_user.last_name = ''
        is_expected.to eq false;
      end
    end

    context 'first_name_kanaカラム' do
      let(:test_user) { user }
      it '空欄でないこと' do
        test_user.first_name_kana = ''
        is_expected.to eq false;
      end
    end

    context 'last_name_kanaカラム' do
      let(:test_user) { user }
      it '空欄でないこと' do
        test_user.last_name_kana = ''
        is_expected.to eq false;
      end
    end

    context 'usernameカラム' do
      let(:test_user) { user }
      it '空欄でないこと' do
        test_user.username = ''
        is_expected.to eq false;
      end
    end

    context 'introductionカラム' do
      let(:test_user) { user }
      it '50文字以下であること' do
        test_user.introduction = Faker::Lorem.characters(number:51)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Postモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:posts).macro).to eq :has_many
      end
    end

    context 'PostCommentモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:post_comments).macro).to eq :has_many
      end
    end

    context 'Favoriteモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end

    context 'Messageモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:messages).macro).to eq :has_many
      end
    end

    context 'Skillモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:skills).macro).to eq :has_many
      end
    end

    context 'Noticeモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:notices).macro).to eq :has_many
      end
    end
  end
end