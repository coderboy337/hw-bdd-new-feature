Rottenpotatoes::Application.routes.draw do
  resources :movies
  # Add new routes here
  resources :movies do
    get 'show_by_director', on: :member
  end
      
  root to: redirect('/movies')
end
