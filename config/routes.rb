Rails.application.routes.draw do
  resources :categories
  resources :tasks
  put '/updateStatus/:id', to: "tasks#update_status"
end
