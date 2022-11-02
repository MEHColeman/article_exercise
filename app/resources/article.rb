# frozen_string_literal: true

# ActiveResource class to handle JSON requests for article information from API
class Article < ActiveResource::Base
  self.site = 'https://s3-eu-west-1.amazonaws.com'

  # This resource interface doesn't quite fit with the ActiveResource expected API
  # so we have to set the end-point for the request manually
  def self.all
    Rails.logger.info 'Retrieving article info from JSON API'
    find(:all, from: 'https://s3-eu-west-1.amazonaws.com/olio-staging-images/developer/test-articles-v4.json')
  end

  def photo_url
    photos.first.files.original
  end
end
