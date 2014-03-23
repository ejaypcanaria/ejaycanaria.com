Admin::Engine.routes.draw do
  resources :admin, path: '/', only: [:index] do

  end
end
