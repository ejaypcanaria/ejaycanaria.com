Admin::Engine.routes.draw do
  root to: "admin#index"

  resources :blogs do

  end

  get "tags/all", as: :get_all_tags, to: "tags#get_all_tags"

end
