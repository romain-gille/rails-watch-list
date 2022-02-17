Rails.application.routes.draw do

  resources :lists, only: [:create, :index, :destroy, :show, :new] do

    resources :bookmarks, only: [:create]
  end
resources :bookmarks, only: [:destroy]


  # get 'bookmarks/new', to: 'bookmarks#new', as: :new_bookmark
  # get 'bookmarks', to: 'bookmarks#index'
  # post 'bookmarks', to: 'bookmarks#create'
  # delete 'bookmarks/:id', to: 'bookmarks#destroy'

  # get 'lists/new', to: 'lists#new', as: :new_list
  # get 'lists', to: 'lists#index'
  # get 'lists/:id', to: 'lists#show', as: :show_list
  # post 'lists', to: 'lists#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
