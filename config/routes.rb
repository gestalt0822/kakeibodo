Rails.application.routes.draw do
  get 'challenges/index'

  get 'challenges/new'

  get 'challenges/create'

  root 'bookings#index'
  devise_for :users
  resources :bookings, except: :show
  resources :categories, only:[:index, :new ,:create, :destroy, :edit, :update]
  resources :sorts, except: :show
end
