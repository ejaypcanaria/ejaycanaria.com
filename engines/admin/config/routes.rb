Admin::Engine.routes.draw do
  root to: "admin#index"

  resources :blogs do

  end
end
