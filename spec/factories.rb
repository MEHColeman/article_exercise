# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    sequence(:id) { |n| n }
    sequence(:title) { |n| "article #{n} title" }
    sequence(:description) { |n| "article #{n} description" }
    photos { FactoryBot.build_list(:photo, 1) }
  end

  factory :photo, class: OpenStruct do
    files { FactoryBot.build(:file) }
  end

  factory :file, class: OpenStruct do
    sequence(:original) { |n| "https://example.com/image_#{n}.jpg" }
  end
end
