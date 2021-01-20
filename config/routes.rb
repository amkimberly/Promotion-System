Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: 'users/registrations',
                                   sessions: 'users/sessions'}
  root 'home#index'
  resources :promotions do
    post 'generate_coupons', on: :member
  end
  resources :product_categories
  resources :coupons, only: [] do
    post 'inactivate', on: :member
  end

  namespace :api do
    namespace :v1 do
      get 'coupons/:code', to: 'coupons#show'
    end
  end
end

