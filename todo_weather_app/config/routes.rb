Rails.application.routes.draw do
  resources :tasks do
    member do
      patch :complete
      patch :incomplete
    end
  end

  # last part is controller name and method name
  get "/weather", to: "weather#weather"
end
