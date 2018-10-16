Rails.application.routes.draw do
  get 'reminders/todays'

  resources :reminders
end
