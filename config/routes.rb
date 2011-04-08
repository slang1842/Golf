Golf::Application.routes.draw do
  resources :hints
  resources :user_sessions
  resource :user, :controller => "user" do
    member do
      get 'bag'
      post 'bag_update'
    end
  end
  
  match "user/bag" => "user#bag"
  match "user/bag_update" => "user#bag_update"
  match "user/bag/:id" => "user#bag_destroy",          :as => :id
  
  
  resource :golf_club, :controller => "golf_club", :path => 'club' do
    resources :fields
  end
  
  #get "users/register"
  get "welcome/index"
  get "home/index"
  get "user_sessions/new"
  
  # match 'user/bag' => "user#bag",            :as => :user_bag
    
  #========================================================================
  #fields
  #match '/users/new' => "users#create"
  #match '/fields' => "fields#index",          :as => :fields
  #match '/fields/new' => "fields#new",          :as => :fields_new
  #match '/fields/edit' => "fields#edit",          :as => :fields_edit
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
  #match '/users/new' => "users#new",          :as => :user_register
  #match '/profile/' => "users#edit",          :as => :user_profile
  
  match '/admin' => "admin#index",          :as => :admin
  
  namespace "admin" do 
    resources :golf_clubs
  end
  
  resources :admin
    
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
