class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
     
      t.string        :email,                :null => false
      t.string        :crypted_password,     :null => false
      t.string        :password_salt,        :null => false
      t.string        :persistence_token,    :null => false
   
      t.boolean        :admin,            	  :default => false # true, false
      #t.integer       :admin,                :default => 0  # club id, or 0, if no club
      
      t.string        :first_name#,           :null => false
      t.string        :last_name#,            :null => false
      t.string        :nick#,                 :null => false
      t.string        :sex#,                  :null => false
      t.date          :birth#,                :null => false
      t.references    :country#,              :null => false
      t.references    :golf_club#,            :null => false
      t.integer       :hcp#,                  :null => false
      t.boolean       :right_handed#,         :null => false
      t.string        :measurement#,          :null => false      #Metri, Pēdas
      t.integer       :start_place_color#,    :null => false      #1,2,3
      #t.string        :profile_image#,        :default => "False"
      
      #image
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at
      
      # magic fields (all optional, see Authlogic::Session::MagicColumns)
      t.integer       :login_count,          :null => false, :default => 0
      t.integer       :failed_login_count,   :null => false, :default => 0
      t.datetime      :last_request_at
      t.datetime      :current_login_at
      t.datetime      :last_login_at
      t.string        :current_login_ip
      t.string        :last_login_ip
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
