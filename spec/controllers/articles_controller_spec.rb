# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'

describe ArticlesController, :type => :controller do
  describe '#index' do
    it 'retrieves all the articles from the Article resource' do
      resource = class_double('Article').as_stubbed_const
      expect(resource).to receive(:all).and_return Object.new

      get :index

      expect(response).to have_http_status(:ok)
    end
  end
end
