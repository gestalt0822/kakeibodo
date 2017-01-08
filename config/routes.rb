Rails.application.routes.draw do
  root 'bookings#index'
  devise_for :users
  resources :bookings, except: :show
  resources :categories, only:[:index, :new ,:create, :destroy, :edit, :update]
end
