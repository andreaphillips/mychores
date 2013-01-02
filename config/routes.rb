Mychoresweb::Application.routes.draw do

  resources :points
  match "/points/create" => "points#create", :via => [:get,:post]
  match "/points/show" => "points#show", :via => [:get,:post]
  match "/points/update" => "points#update", :via => [:get,:post]
  match "/points/delete" => "points#delete", :via => [:get,:post]

  resources :kids
  match "/kids/create" => "kids#create",:via => [:get, :post]
  match "/kids/update" => "kids#update",:via => [:get, :post]
  match "/kids/delete" => "kids#destroy",:via => :post

  get "root/index"
  match '/' => "root#index"

  get "root/index"
  match '/login' => "root#login"

  get 'users/create'
  match "/users/create" => "users#create",:via => [:get, :post]


  get "users/edit"

  get "users/delete"

  get "users/show"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
