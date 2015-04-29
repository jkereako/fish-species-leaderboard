Rails.application.routes.draw do
  # Prevent new users from registering new accounts. This is an invite-only app
  devise_for :users, skip: 'registrations'

  # Make the leaderboard the home page
  root 'leaderboard#index', as: 'leaderboard'
end
