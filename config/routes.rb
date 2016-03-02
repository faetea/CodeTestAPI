Rails.application.routes.draw do

resources :parents, :children

  get 'parents' => 'parents#index'
  get 'parents/:id' => 'parents#show'
  post 'parents' => 'parents#create'
  patch 'parents/:id' => 'parents#update'

  get 'children' => 'children#index'
  get 'children/:id' => 'children#show'
  post 'children' => 'children#create'
  patch 'children/:id' => 'children#update'

end
