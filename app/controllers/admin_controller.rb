class AdminController < ApplicationController
  before_filter :require_super_admin, :except => :index
  skip_before_filter :require_no_super_admin
  skip_before_filter :require_user #, :only => :index
  before_filter :require_user, :only => :index
    
  def index   
    if current_user
      unless current_user.is_super_admin
        current_user_session.destroy
        redirect_to welcome_url
        flash[:notice] = "You have no access to this page"
      end
    end
  end

	def edit_help
		@help_text = ""
		@help_file = File.open("app/views/share/_help_text.html.erb", "r") do |f|
			while (line = f.gets)
				@help_text += line
			end
		end
	end

	def save_help
		@help_file = File.open("app/views/share/_help_text.html.erb", "r+") do |f|
			f.truncate(0)
			@help_text = f.syswrite(params[:help_text])
		end
		redirect_to admin_path
	end

	def edit_text
		fetch_texts
	end

	def save_text
		@help_file = File.open("more_text.txt", "r+") do |f|
			f.truncate(0)
			@help_text = f.syswrite(params[:more_text])
		end
		@help_file = File.open("header_text.txt", "r+") do |f|
			f.truncate(0)
			@help_text = f.syswrite(params[:header_text])
		end
		@help_file = File.open("icon_1_text.txt", "r+") do |f|
			f.truncate(0)
			@help_text = f.syswrite(params[:icon_1_text])
		end
		@help_file = File.open("icon_2_text.txt", "r+") do |f|
			f.truncate(0)
			@help_text = f.syswrite(params[:icon_2_text])
		end
		@help_file = File.open("icon_3_text.txt", "r+") do |f|
			f.truncate(0)
			@help_text = f.syswrite(params[:icon_3_text])
		end
		redirect_to admin_path
		
	end

	private
	
	def fetch_texts
			@more_text = ""
			@header_text = ""
			@icon_1_text = ""
			@icon_2_text = ""
			@icon_3_text = ""
			@text = File.open("more_text.txt", "r") do |f|
				while (line = f.gets)
					@more_text += line
				end
			end
			@text = File.open("header_text.txt", "r") do |f|
				while (line = f.gets)
					@header_text += line
				end
			end
			@text = File.open("icon_1_text.txt", "r") do |f|
				while (line = f.gets)
					@icon_1_text += line
				end
			end
			@text = File.open("icon_2_text.txt", "r") do |f|
				while (line = f.gets)
					@icon_2_text += line
				end
			end
			@text = File.open("icon_3_text.txt", "r") do |f|
				while (line = f.gets)
					@icon_3_text += line
				end
			end
		end

end
