Golf::Application.routes.draw do
  get "users/register"
  get "welcome/index"
  get "home/index"
  get "user_sessions/new"

  resources :user_sessions
  resources :clubs
  resources :users
  
  root :to => "clubs#index", :as => :clubs
  
  #========================================================================
  #welcome
  match '/welcome' => "welcome#index"
  #========================================================================
  #login
  match '/login' => "user_sessions#new",      :as => :login
  match '/logout' => "user_sessions#destroy", :as => :logout
  #========================================================================
  #clubs
  match '/clubs' => "club#index"
  #========================================================================
  #user profiles
  match '/users/new' => "users#new", :as => :user_register
  match '/users/profile' => "users#edit", :as => :user_edit
    
  
  
  
  
 # match '/' => "user_sessions#index",         :as => :login
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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
