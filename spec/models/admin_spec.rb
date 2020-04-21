require 'rails_helper'

RSpec.describe 'Adminモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:admin) { build(:admin) }
    subject { test_admin.valid? }
    context 'emailカラム' do
      let(:test_admin) { admin }
      it '空欄でないこと' do
        test_admin.email = ''
        is_expected.to eq false;
      end
    end
    context 'passwordカラム' do
      let(:test_admin) { admin }
      it '空欄でないこと' do
        test_admin.password = ''
        is_expected.to eq false;
      end
    end

  end
  describe 'アソシエーションのテスト' do
    context 'Newsモデルとの関係' do
      it '1:Nとなっている' do
        expect(Admin.reflect_on_association(:news).macro).to eq :has_many
      end
    end
    context 'Menuモデルとの関係' do
      it '1:Nとなっている' do
        expect(Admin.reflect_on_association(:menus).macro).to eq :has_many
      end
    end
  end
end