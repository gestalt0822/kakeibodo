Rails.application.routes.draw do
  root 'bookings#index'
  devise_for :users
  resources :bookings, except:[:show, :destroy]  do
    member do
      patch :unlist
    end
    collection do
      get 'get_sorts'
    end
    collection do
      post 'new_category'
      post 'new_sort'
    end
  end
  resources :categories, only:[:index, :new ,:create, :destroy, :edit, :update]
  resources :sorts, except: :show
  resources :challenges, except: :destroy do
    member do
      patch :finish
      get :finish
    end
  end
  resources :users, only:[:index, :show]
  resources :analyses, only:[:index]
end
