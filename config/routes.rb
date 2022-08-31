# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations' },
                     path_names: {  edit: 'settings' }
  root 'home_pages#home'
  resources :books, only: %i[index show]
  resource :address, only: [:update]
end
