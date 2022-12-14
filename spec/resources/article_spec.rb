# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Article do
  subject { Article.all.first }

  before(:each) do
    ActiveResource::HttpMock.respond_to do |mock|
      mock.get 'https://s3-eu-west-1.amazonaws.com/olio-staging-images/developer/test-articles-v4.json', {},
               File.read('spec/fixtures/two-test-articles.json')
    end
  end
  after(:each) do
    ActiveResource::HttpMock.reset!
    ActiveResource::HttpMock.enable_net_connection!
  end

  it 'has an ID property' do
    expect(subject.id).to eq 3899631
  end

  it 'has a title' do
    expect(subject.title).to eq 'Ambipur air freshener plugin'
  end

  it 'has a description' do
    expect(subject.description).to eq 'Device only but refills are available most places'
  end

  it 'has an photo location url' do
    expect(subject.photo_url).to eq 'https://cdn.olioex.com/uploads/photo/file/00gRGrBRDFYrR2j-9SJVYg/image.jpg'
  end

  describe '#liked?' do
    context 'when a corresponding Like exists' do
      before(:each) do
        Like.create(article_id: 3899631)
      end
      it 'returns true' do
        expect(subject.liked?).to be_truthy
      end
    end

    context 'when a corresponding Like does not exist' do
      it 'returns false' do
        expect(subject.liked?).to be_falsey
      end
    end
  end
end
