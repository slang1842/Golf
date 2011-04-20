Golf::Application.routes.draw do
  resources :statistics
  resources :hits
  resources :users_sticks
  resources :balls
  resources :sticks
  resources :games
  resources :users_sticks
  resources :hints
  resources :user_sessions
  resource :admin
  
  resources  :statistics do
    resources :PairHit
  end
  
  #statistics
  #================
  match '/s' => "statistic#statistics",   :as => "s"
  
  resource :user, :controller => "user" do
    collection do
      get "bag"
      post "update_bag"
      put "update_bag"
    end
  end
  
  resource :golf_club, :controller => "golf_club", :path => 'club' do
    resources :fields
  end
  
  get "welcome/index"
  get "home/index"
  get "user_sessions/new"
  
  #statistics
  #========================================================================
  match '/statistics/' => "statistics#index", :as => "statistics"
  #game
  #========================================================================
  match '/game_edit/:id' => "games#game_index", :as => 'game_edit' 
  match '/prev/:active/:id/:form_id/:hit_type' => "games#prev", :as => 'hole_prev'
  match '/next/:active/:id/:form_id/:hit_type' => "games#next", :as => 'hole_next'
  match '/details/:id/:active' => "games#details", :as => 'details'
  match '/plan/:id/:active' => "games#plan", :as => 'plan'
  match '/results/:id/:active' => "games#results", :as => 'results'
  match '/hit_next/:hit/:form_id/:id/:active_hole/:hit_type' => "games#hit_next", :as => 'hit_next'
  match '/hit_prev/:hit/:form_id/:id/:active_hole/:hit_type' => "games#hit_prev", :as => 'hit_prev'
  match '/hits/:game_id' => "hits#index", :as => 'hits_index'
  match '/save_game' => 'games#save', :as => 'save_game'
  match '/game_index' => 'games#index', :as => 'game_index'
  #========================================================================
  #welcome
  root :to => "welcome#welcome",              :as => :welcome
  match '/welcome' => "welcome#index",        :as => :loged_in
  
  match '/register' => "user_sessions#index", :as => :login_or_register
  #========================================================================
  #login
  match '/login' => "user_sessions#new",      :as => :login
  match '/logout' => "user_sessions#destroy", :as => :logout
  
  #========================================================================
  #user profiles
  match '/admin' => "admin#index",          :as => :admin
  
  namespace "admin" do 
    resources :golf_clubs
    resources :sticks
    resources :users
    resources :hints
  end
  
  
    
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
