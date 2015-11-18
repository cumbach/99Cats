Rails.application.routes.draw do
  resources :cat_rental_requests, only: [:index, :show, :new, :create]

  resources :cats, only: [:index, :show, :new, :create, :edit, :update]
end
