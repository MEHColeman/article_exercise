require 'rails_helper'

RSpec.describe 'articles/index' do
  context 'when connected to external api' do

    it 'renders a list of articles' do
      render

      expect(rendered).to match('Ambipur air freshener plugin')
      expect(rendered).to match('Baby float seat')
    end
  end
end
