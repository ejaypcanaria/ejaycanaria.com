Admin::Engine.routes.draw do
  root to: "admin#index"

  resources :blogs, only: [:index] do

  end
end
