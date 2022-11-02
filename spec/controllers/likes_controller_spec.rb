# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'

describe LikesController, :type => :controller do
  describe '#create' do
    context 'article_id is provided' do
      let(:params) { { article_id: 1 } }

      it 'creates a new like in the database ' do
        expect(Like.where(article_id: 1).count).to eq 0

        post :create, params: params

        expect(Like.where(article_id: 1).count).to eq 1
        expect(response).to have_http_status(:ok)
      end

      it 'will work fine if a like already exists' do
        Like.create(article_id:1)

        post :create, params: params

        expect(Like.where(article_id: 1).count).to eq 1
        expect(response).to have_http_status(:ok)
      end
    end

    context 'article_id is not providied' do
      let(:params) { {} }

      it 'returns an error response' do
        post :create, params: params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe '#destroy' do
    context 'article_id is provided' do
      let(:params) { { article_id: 1 } }

      it 'deletes an existing like in the database ' do
        Like.create(article_id:1)
        expect(Like.where(article_id: 1).count).to eq 1

        post :destroy, params: params

        expect(Like.where(article_id: 1).count).to eq 0
        expect(response).to have_http_status(:ok)
      end

      it 'will work fine if a like does not already exist' do

        post :destroy, params: params

        expect(Like.where(article_id: 1).count).to eq 0
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
