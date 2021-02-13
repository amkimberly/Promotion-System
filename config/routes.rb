Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: 'users/registrations'}
  root 'home#index'
  resources :promotions do
    post 'generate_coupons', on: :member
    get 'search', on: :collection
  end
  resources :product_categories
  resources :coupons, only: [] do
    post 'cancel', on: :member
    get 'search', on: :collection
  end

  namespace :api do
    namespace :v1 do
      resources :coupons, param: :code, only: %i[show] do
        post 'inactivate', on: :member
      end
    end
  end
end

