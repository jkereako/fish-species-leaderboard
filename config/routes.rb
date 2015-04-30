Rails.application.routes.draw do
  resources :competitions

  resources :competitions, only: [:new, :edit] do
    resources :users, only: [:new, :edit]
  end

  # Prevent new users from registering new accounts.
  # This app is invite only.
  devise_for :users, skip: :registrations

  # Restrict updating catches to users
  resources :users, only: [:index, :show] do
    resources :catches, only: [:new, :edit]
  end

  # Allow all users to view all catches
  resources :catches, only: [:index, :show]

  # Make the leaderboard the home page
  root 'leaderboard#index', as: :leaderboard
end
