Rails.application.routes.draw do
  root 'bookings#index'
  devise_for :users
  resources :bookings, except: :show  do
    collection do
      get 'get_sorts'
    end
  end
  resources :categories, only:[:index, :new ,:create, :destroy, :edit, :update]
  resources :sorts, except: :show
end
