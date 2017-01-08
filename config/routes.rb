Rails.application.routes.draw do
  devise_for :users
  resources :bookings, except: :show
  root 'bookings#index'
  resources :categories, only:[:index, :new ,:create, :destroy, :edit, :update]
end
