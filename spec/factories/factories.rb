require 'rails_helper'

FactoryBot.define do
  factory :user do
    email { 'test@test.com'}
    username { 'Tester'}
    password { '123456'}
  end

  factory :user2 do
    email { 'test2@test.com'}
    username { 'Tester2'}
    password { '123456'}
  end

  factory :prompt do
    movie_a { 'Titanic' }
    movie_b { 'Usual Suspects' }
  end

  factory :post do
    body { 'The main character of Movie 1 is a horrible creature who kills the child of the main character in Movie 2.' }
  end

end
