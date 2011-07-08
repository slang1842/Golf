class Admin::HintsController < ApplicationController
  before_filter :require_super_admin
  layout "admin"
  skip_before_filter :require_no_super_admin

  def index
    @all_admins = User.where(:admin => true)
    @all_hints = Hint.all
  end
  
end






















