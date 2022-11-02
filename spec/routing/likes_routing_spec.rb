# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LikesController, type: :routing do
  describe 'routing' do
    it 'routes to #create' do
      expect(get: '/likes/create').to route_to('likes#create')
    end

    it 'routes to #destroy' do
      expect(get: '/likes/destroy').to route_to('likes#destroy')
    end
  end
end
