# frozen_string_literal: true

class ArticlesController < ApplicationController
  def index
    Rails.logger.info 'Retrieving all Articles'
    @articles = Article.all
  end
end
