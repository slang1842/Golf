class PasswordResetsController < ApplicationController
		before_filter :load_user_using_perishable_token, :only => [:edit, :update] 
		before_filter :require_no_user, :only => [:new, :create]

	def new  
		respond_to :js
	end  
  
	def create  
		@user = User.find_by_email(params[:email])  
		if @user  
			@user.deliver_password_reset_instructions!  
			flash[:notice] = "Instructions to reset your password have been emailed to you. " +  "Please check your email."  
			redirect_to welcome_path  
		else  
			flash[:notice] = "No user was found with that email address"  
			redirect_to welcome_path  
		end  
	end 
  
	def edit  
		render  
	end  
  
	def update  
		@user.password = params[:user][:password]  
		@user.password_confirmation = params[:user][:password_confirmation]  
		if @user.save  
			#flash[:notice] = "Password successfully updated"  
			redirect_to loged_in_path  
		else	  
			flash[:notice] = "Please, enter at least 4 characters!"
			render :action => :edit  
		end  
	end  
  
private  

	def load_user_using_perishable_token  
		@user = User.find_by_perishable_token(params[:id])  
		puts @user.first_name
	unless @user  
		flash[:notice] = "We're sorry, but we could not locate your account. " +  
		"If you are having issues try copying and pasting the URL " +  
		"from your email into your browser or restarting the " +  
		"reset password process."  
		redirect_to welcome_path  
	end  
	end  

end
