Rails.application.routes.draw do
  root 'bookings#index'
  devise_for :users
  resources :bookings, except: :show
  resources :categories, only:[:index, :new ,:create, :destroy, :edit, :update]
  resources :sorts, except: :show
  resources :challenges, only:[:index, :new ,:create, :edit, :update] do
    member do
      patch :finish
    end
  end
  resources :users, only:[:index, :show]
end
