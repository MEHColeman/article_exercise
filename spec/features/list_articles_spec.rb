# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Listing Articles', type: :feature do
  scenario 'User visits homepage and views a list of articles' do
    visit '/'

    expect(page).to have_text('Ambipur air freshener plugin')
    expect(page).to have_text('Baby float seat')
  end

  scenario 'User likes an article', js: true do
    visit '/'
    expect(page).to_not have_text('♥')

    page.find_by_id('3899631').click

    expect(page).to have_text('♥', wait: 5)
  end
end
