Rails.application.routes.draw do
  root "projects#index"

  resources :projects do
    resources :tasks do
      member do
        put :completed
        put :uncompleted
      end
      post :position, on: :collection
    end
  end

end
