Rails.application.routes.draw do
  devise_for :users
  authenticated :user do
    root 'event_notifications#index', as: :authenticated_root
    resources :event_notifications
    post 'event_notifications/create_event'
    post 'event_notifications/create_event_with_notification'
  end
  
  unauthenticated :user do
    root to: redirect('/users/sign_in')
  end
end
