# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :posts, only: :create
      resources :scores, only: :create
    end
  end
end
