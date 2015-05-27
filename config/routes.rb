Rails.application.routes.draw do
  resources :competitions
  resources :catches

  # Prevent new users from registering new accounts.
  # This app is invite only.
  # devise_for :users, skip: 'registrations'
  devise_for :users, skip: 'registrations'
  as :user do
    get 'users/edit' => 'devise/registrations#edit',
        as: 'edit_user_registration'
    put 'users/:id' => 'devise/registrations#update',
        as: 'user_registration'
  end

  # Restrict updating catches to users
  resources :users, only: [:index, :show]

  # Make the leaderboard the home page
  root 'leaderboard#index', as: :leaderboard
end
