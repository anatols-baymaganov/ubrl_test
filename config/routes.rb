# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :posts, only: :create do
        get :top, on: :collection
      end
      resources :scores, only: :create
      resources :users, only: [] do
        get :author_ips, on: :collection
      end
    end
  end
end
