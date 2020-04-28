Rails.application.routes.draw do
  root "projects#index"

  resources :projects do
    resources :tasks do
      member do
        patch :done
        patch :undone
      end
    end
  end
end
