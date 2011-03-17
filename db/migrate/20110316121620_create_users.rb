class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
     
      t.string    :email,               :null => false
      t.string    :crypted_password,    :null => false
      t.string    :password_salt,       :null => false
      t.string    :persistence_token,   :null => false
   
      t.string    :user_type            :default => "user"   # user or admin
      t.integer   :admin                :default => "false"  # club id, or false
      
      t.string    :first_name
      t.string    :last_name
      t.string    :nick
      t.string    :sex
      t.date      :birth
      t.string    :country
      t.integer   :home_club
      t.integer   :hcp
      t.boolean   :right_handed
      t.string    :measurement
      t.integer   :start_place
      t.string    :profile_image  
      
      # magic fields (all optional, see Authlogic::Session::MagicColumns)
      t.integer   :login_count,         :null => false, :default => 0
      t.integer   :failed_login_count,  :null => false, :default => 0
      t.datetime  :last_request_at
      t.datetime  :current_login_at
      t.datetime  :last_login_at
      t.string    :current_login_ip
      t.string    :last_login_ip
      t.timestamps
    end

    #add_index :users, ["login"], :name => "index_users_on_login", :unique => true
    add_index :users, ["email"], :name => "index_users_on_email", :unique => true
    add_index :users, ["persistence_token"], :name => "index_users_on_persistence_token", :unique => true

  end

  def self.down
    drop_table :users
  end
end
