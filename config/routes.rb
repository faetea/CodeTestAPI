Rails.application.routes.draw do

  get 'parents' => 'parents#index'
  get 'parents/:id' => 'parents#show'
  post 'parents' => 'parents#create'
  patch 'parents/:id' => 'parents#update'
  delete 'parents/:id' => 'parents#destroy'

  get 'children' => 'children#index'
  get 'children/:id' => 'children#show'
  post 'children' => 'children#create'
  patch 'children/:id' => 'children#update'
  delete 'children/:id' => 'children#destroy'

end
