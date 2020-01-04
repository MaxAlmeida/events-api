Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :events do
    resources :comments
    get 'reports', to: 'comments#reports'
  end

  post 'reports', to: 'reports#create'
  post 'signup', to: 'users#create'
end
