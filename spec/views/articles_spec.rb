# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'articles/index' do
  context 'when connected to external api' do
    it 'renders a list of articles' do
      assign(:articles, Article.all)
      render

      expect(rendered).to match('Ambipur air freshener plugin')
      expect(rendered).to match('Baby float seat')
    end
  end

  context 'with fixtured data' do
    before(:each) do
      assign(:articles, FactoryBot.build_list(:article, 5))
    end

    it 'renders a list of articles' do
      render

      expect(rendered).to match('article 1 title')
      expect(rendered).to match('article 5 title')
    end
  end
end
