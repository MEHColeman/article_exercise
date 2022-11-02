# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Listing Articles', type: :feature do
  scenario 'User visits homepage and views a list of articles' do

    visit '/'

    expect(page).to have_text('Ambipur air freshener plugin')
    expect(page).to have_text('Baby float seat')
  end
end
