Rails.application.routes.draw do
  devise_for :users
  resources :bookings, except: :show
end
