Golf::Application.routes.draw do
	default_url_options :host => "localhost:3000"
  resources :game_statistics

  resources :games
  resources :hits
  resources :users_sticks
  resources :balls
  resources :sticks
  resources :games
  resources :users_sticks
  resources :hints
  resources :user_sessions
  resources :pair_hits
	resources :password_resets
   
  #statistics
  #================
  #resources
  #match '/statistic/:user_id/:field_id' => 'statistic#edit', :as => 'main_statistic'
  #match '/statistic/:user_id/:field_id' => 'statistic#edit', :as => 'main_statistic'
  #end
  match '/filter_statistic' => 'statistic#filter_statistic'
  match '/user_place_in_golf_club' => 'statistic#user_place_in_golf_club'

  match 'statistic/get_mini_statistic_by_field/:field_id/:user_id' => 'statistic#get_statistic_by_field'
  resource :statistic, :controller => "statistic" do
    member do
      match 'user/:user_id/' => 'statistic#edit', :as => "main"
    end
    collection do
      get "hints"
      post "update_hints"
      put "update_hints"
    end
  end


  
  match '/s' => "statistic#statistics",   :as => "s"
  match '/ss' => "statistic#view", :as => "view_statistic"
      
  resource :user, :controller => "user" do
    collection do
      get "bag"
      post "update_bag"
      put "update_bag"
    end
  end
  
  resource :golf_club, :controller => "golf_club", :path => 'club' do
    resources :fields
    collection do
      get "show"
    end
  end

 
  
  
  get "welcome/index"
  get "home/index"
  get "user_sessions/new", :as => 'new_user_session'

  #club
  match '/club/edit_fields/' => 'golf_club#edit_fields'
  match '/user/update_hints/:id' => 'user#update_hints'

  #game
  match '/edit_field_by_id/:id' => 'fields#edit'
  match '/hole_switch/:game_id/:active_hole/:direction/:form_id/:hits/:puts' => 'games#hole_switch', :as => 'hole_switch'
  match '/hit_switch/:game_id/:active_hole/:direction/:active_hit/:form_id' => 'games#hit_switch', :as => 'hit_switch'
  match '/game_new/:form_id' => 'games#new', :as => 'new_game'
  match '/game_plan/:game_id/:active_hole/:active_hit' => 'games#plan', :as => 'plan'
  match '/game_plan/:game_id/:active_hole/:active_hit/:hits' => 'games#plan', :as => 'plan'
  match '/game_plan/:game_id/:active_hole/:active_hit/0/0' => 'games#plan', :as => 'plan'
  match '/game_res/:game_id/:active_hole/:active_hit/:hits' => 'games#res', :as => 'res'
  match '/game_results/:game_id/:active_hole/:active_hit' => 'games#results', :as => 'results'
  match '/game_results/:game_id/:active_hole/:form_id/:hits/:puts' => 'games#results', :as => 'results'
  match '/game_details/:game_id/:active_hole/:active_hit' => 'games#details', :as => 'details'
  match '/game_details/:game_id/:active_hole/:active_hit/:hits/:puts' => 'games#details', :as => 'details'
  match '/more_games/:count' => 'games#more_games', :as => 'more_games'
  match '/results_starter/' => 'games#results_starter'
  match '/games/' => 'games#index', :as => 'game_index'
  match '/hit_update/:game_id/' => 'games#hit_update'
  match '/print_game_plan/:game_id/' => 'games#print_game_plan', :as => 'print_game_plan'
  match '/single_game_statistics/:game_id' => 'games#get_stats', :as => 'get_stats'
  match '/add_planned_hit/:game_id/:hole_number/:active_hit' => 'games#add_planned_hit', :as => 'add_planned_hit'
  match '/remove_planned_hit/:game_id/:hole_number/:active_hit' => 'games#remove_hit', :as => 'remove_planned_hit'
	match '/games/switch_colors/:id' => 'games#switch_hit_places'
  #welcome
  root :to => "welcome#welcome",              :as => :welcome
  match '/welcome' => "welcome#index",        :as => :loged_in
  
  match '/register' => "user_sessions#index", :as => :login_or_register
  
  #login
  match '/login' => "user_sessions#new",      :as => :login
  match '/logout' => "user_sessions#destroy", :as => :logout
  
  #admin
  match '/admin' => "admin#index",                 :as => :admin
  match '/sticks-list' => "admin/sticks#index",    :as => :admin_list_sticks

  
  #match "admin/users/:user_id" => "admin#", :as => 'give_admin_rights'
  #  match "admin/sticks" => "admin/sticks#index", :as => "admin_sticks"
  #  post "admin/sticks/create"  => "admin/sticks#create", :as => "create_admin_stick"
  #  match "admin/sticks/new" => "admin/sticks#new"
  
  namespace "admin" do
    resources :golf_clubs
    resources :sticks
    resources :users
    resources :hints
    resources :countries
    match "admin/users/acc/:id" => "users#give_admin_rights", :as => 'give_admin_rights'
  end
  
 match "reset_password" => "password_resets#update"
  
    
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
