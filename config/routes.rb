Rails.application.routes.draw do
  resources :competitions do
    # REVIEW: Reverse the order from /competitions/:competition_id/suspend
    # to /competitions/suspend/:competition_id
    put :suspend, on: :member
  end

  resources :catches

  # Prevent new users from registering new accounts.
  # This app is invite only.
  # devise_for :users, skip: 'registrations'
  devise_for :users, controllers: { invitations: 'invitations' },
                     skip: 'registrations'
  as :user do
    get 'users/edit' => 'devise/registrations#edit',
        as: 'edit_user_registration'
    put 'users/:id' => 'devise/registrations#update',
        as: 'user_registration'
    put 'users/:id/toggle_activation' => 'users#toggle_activation',
        as: 'toggle_user_activation',
        format: 'json',
        constraints: -> (req) { req.xhr? }
  end

  # Restrict updating catches to users
  resources :users, only: [:index, :show]

  # Make the leaderboard the home page
  root 'leaderboard#index'
end
