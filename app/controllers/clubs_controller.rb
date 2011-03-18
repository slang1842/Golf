class ClubsController < GolfMainController
  # GET /clubs
  # GET /clubs.xml
  
  # before_filter :require_no_user
  
  
  before_filter :require_user
  
  def index
    @get_type = :get_type
  end

  
  
end
