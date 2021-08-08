Rails.application.routes.draw do
  resources :fields, only: [:index] do
    collection do
      post 'humus_balance'
    end
  end

  resources :crops, only: [:index]
end
