Rails.application.routes.draw do
  resources :bookings, except: :show
end
