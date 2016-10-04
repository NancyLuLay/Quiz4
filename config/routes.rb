Rails.application.routes.draw do
  resources :auctions, only:[:new, :create, :show, :index, :destroy] do
    resources :bids, only:[:index, :create, :destroy]
  end

  resources :users, only:[:new, :create]
  resources :sessions, only:[:new, :create] do
    delete :destroy, on: :collection
  end

root "auctions#index"
get 'auctions/index_all' => 'auctions#index_all'

end
