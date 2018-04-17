Rails.application.routes.draw do
  get 'actuals/view'

  resources :ochanges
  resources :others
  get 'sandboxes/people'

  get 'sandboxes/other'
  get 'sandboxes/change'
  get 'sandboxes/approved'
  get 'sandboxes/declined'
  get 'sandboxes/bmo'

  resources :pchanges
  get 'dashboard/view'
  get 'dashboard/summary'

  resources :people
  root   'sessions#new'
  get    '/help',    to: 'static_pages#help'
  get    '/about',   to: 'static_pages#about'
  get    '/contact', to: 'static_pages#contact'
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get    '/get_teams', to: 'dashboard#get_teams'
  resources :users
  resources :account_activations, only: [:edit]
end
