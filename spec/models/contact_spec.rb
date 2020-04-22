require 'rails_helper'

RSpec.describe 'Noticeモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:contact) { create(:contact) }
    context 'titleカラム' do
      it '空欄でないこと' do
        contact.body = ''
        expect(contact.valid?).to eq false;
      end
    end
    context 'bodyカラム' do
      it '空欄でないこと' do
        contact.body = ''
        expect(contact.valid?).to eq false;
      end
    end
  end
end