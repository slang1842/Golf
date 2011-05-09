Golf::Application.routes.draw do
  resources :games

  resources :statistic
  resources :hits
  resources :users_sticks
  resources :balls
  resources :sticks
  resources :games
  resources :users_sticks
  resources :hints
  resources :user_sessions
  resources :pair_hits
  resources :user_stats do
  collection  do
    get 'populate'
  end
end
  
  

  
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
  #game_OLD
  #========================================================================
  # match '/game_edit/:id/:form_type' => "games#game_index", :as => 'game_edit' 
  # match '/prev/:active/:id/:form_id/:hit_type/:count' => "games#prev", :as => 'hole_prev'
  # match '/next/:active/:id/:form_id/:hit_type/:count' => "games#next", :as => 'hole_next'
  # match '/preva/:active/:id' => "games#preva", :as => 'preva'
  # match '/nexta/:active/:id' => "games#nexta", :as => 'nexta'
  # match '/details/:id/:active' => "games#details", :as => 'details'
  # match '/plan/:id/:active' => "games#plan", :as => 'plan'
  # match '/results' => 'games#results', :as => 'game_results'
  # match '/hit_next/:hit/:form_id/:id/:active_hole/:hit_type' => "games#hit_next", :as => 'hit_next'
  # match '/hit_prev/:hit/:form_id/:id/:active_hole/:hit_type' => "games#hit_prev", :as => 'hit_prev'
  # match '/hits/:game_id' => "hits#index", :as => 'hits_index'
  # match '/save_game' => 'games#save', :as => 'save_game'
  # match '/save_games/:count' => 'games#save_many', :as => 'save_games'
  # match '/game_index' => 'games#index', :as => 'game_index'
  # match '/result_render/:id/:active'=> 'games#result_render', :as => 'results_render'
  # match '/game_new/:form_type' => 'games#new', :as => 'new_game'
  # #========================================================================
  #game
  match '/hole_switch/:game_id/:active_hole/:direction/:form_id/:hits/:puts' => 'games#hole_switch', :as => 'hole_switch'
  match '/hit_switch/:game_id/:active_hole/:direction/:active_hit/:form_id' => 'games#hit_switch', :as => 'hit_switch'
  match '/game_new/:form_id' => 'games#new', :as => 'new_game'
  match '/game_plan/:game_id/:active_hole/:active_hit' => 'games#plan', :as => 'plan'
  match '/game_plan/:game_id/:active_hole/:active_hit/0/0' => 'games#plan', :as => 'plan'
  match '/game_res/:game_id/:active_hole/:active_hit' => 'games#res', :as => 'res'
  match '/game_results/:game_id/:active_hole/:form_id/:hits/:puts' => 'games#results', :as => 'results'
  match '/game_details/:game_id/:active_hole/:active_hit/:hits/:puts' => 'games#details', :as => 'details'
  match '/game_details/:game_id/:active_hole/:active_hit' => 'games#details', :as => 'details'
  match '/results_starter/' => 'games#results_starter'
  match '/games/' => 'games#index', :as => 'game_index'
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
    resources :countries
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
