SitProjet::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase
  get   '/registration'  => 'users#new'
  post  '/registration'  => 'users#create'
  get   '/login' => "sessions#new"
  post  'login' => "sessions#create"
  get   '/logout' => 'sessions#destroy'
  get   '/keys/destroy' => "keys#destroy"
  get   '/friends/destroy' => "friends#destroy"
  post   '/friends/create' => "friends#create"
  post   '/keys/new' => "keys#create"
  get   '/encrypted/:id'  =>"documents#get_encrypted_document"
  get   '/decrypted/:id' =>"documents#get_decrypted_document"
  post   '/decryptfile'   =>"documents#crypt_with_key"
  get    '/privatekey/:id' => "key_pairs#private_key"
  get    '/publickey/:id'  => "key_pairs#public_key"
  resources :keys
  resources :documents
  resources :friends
  resources :loans
  resources :key_pairs
  resources :distributed_documents




  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
