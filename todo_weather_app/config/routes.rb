Rails.application.routes.draw do
  resources :tasks do
    member do
      patch :complete
      patch :incomplete
    end
  end
end
