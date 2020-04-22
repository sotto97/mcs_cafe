require 'rails_helper'

RSpec.describe 'Noticeモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:user) { create(:user) }
    let!(:notice) { build(:notice, user_id: user.id) }

    context 'bodyカラム' do
      it '空欄でないこと' do
        notice.body = ''
        expect(notice.valid?).to eq false;
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Notice.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end