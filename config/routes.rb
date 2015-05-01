Rails.application.routes.draw do
  resources :competitions
  resources :catches
  # Prevent new users from registering new accounts.
  # This app is invite only.
  devise_for :users, skip: :registrations

  # Restrict updating catches to users
  resources :users, only: [:index, :show]

  # Make the leaderboard the home page
  root 'leaderboard#index', as: :leaderboard
end
