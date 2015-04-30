Rails.application.routes.draw do
  resources :competitions
  # Prevent new users from registering new accounts.
  # This app is invite only.
  devise_for :users, skip: :registrations

  # Display list of users and user detail.
  resources :users, only: [:index, :show] do
    resources :catches
  end

  # Allow users to view a list of the recorded catches
  resources :catches, only: [:index, :show]

  # Make the leaderboard the home page
  root 'leaderboard#index', as: :leaderboard
end
