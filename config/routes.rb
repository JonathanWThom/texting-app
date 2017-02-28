Rails.application.routes.draw do
  resources :messages, :only => [:index, :new, :create, :show] do
    collection do
      post 'reply'
    end
  end
  resources :contacts, :only => [:index, :new, :create, :show]
  root to: 'home#index'
end
