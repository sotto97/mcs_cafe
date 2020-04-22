require 'rails_helper'

RSpec.describe 'Newsモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:admin) { create(:admin) }
    let!(:news) { build(:news, admin_id: admin.id) }
    context 'titleカラム' do
      it '空欄でないこと' do
        news.title = ''
        expect(news.valid?).to eq false;
      end
    end
    context 'bodyカラム' do
      it '空欄でないこと' do
        news.body = ''
        expect(news.valid?).to eq false;
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Adminモデルとの関係' do
      it 'N:1となっている' do
        expect(News.reflect_on_association(:admin).macro).to eq :belongs_to
      end
    end
  end
end