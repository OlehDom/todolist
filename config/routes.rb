Rails.application.routes.draw do
  root "projects#index"

  resources :projects do
    post :position, on: :collection
    resources :tasks do
      member do
        put :completed
        put :uncompleted
      end
      post :position, on: :collection
    end
  end
end
