require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'database schema' do
    it { is_expected.to have_db_column(:article_id).of_type(:integer).with_options(null: false) }
  end

  describe 'validations' do
    context 'without an article id' do
      subject { Like.new(article_id: nil) }
      it 'is not valid' do
        expect(subject).to_not be_valid
      end
    end

    context 'with an article id' do
      subject { Like.new(article_id: 1) }
      it 'is valid' do
        expect(subject).to be_valid
      end
    end
  end
end
