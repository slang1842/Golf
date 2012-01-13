class FieldsController < ApplicationController
  
  def new
    @golf_club = current_user.golf_club
    @field = @golf_club.fields.new
    @new_hole_attributes_name = "holes_attributes[]"
    @new_hit_place_attributes_name = "hit_places_attributes[]"
    @new_green_fee_attributes_name = "green_fees_attributes[]"
  end

  def edit
    @field = Field.find(params[:id])
    @hole_attributes_name = "holes_attributes[]"
    @new_hole_attributes_name = (@field.holes.count > 0) ? "new_holes_attributes[]" : @hole_attributes_name
    @hit_place_attributes_name = "hit_places_attributes[]"
    @new_hit_place_attributes_name = (@field.hit_places.count > 0) ?  "new_hit_places_attributes[]" : @hit_place_attributes_name
    @green_fee_attributes_name = "green_fees_attributes[]"
    @new_green_fee_attributes_name = (@field.green_fees.count > 0) ?  "new_green_fees_attributes[]" : @green_fee_attributes_name
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @field }
    end
  end

  def create
    @golf_club = current_user.golf_club
    @field = @golf_club.fields.new(params[:field])
    
    respond_to do |format|
      if @field.save
     
        format.html { redirect_to('/club/edit_fields', :notice => "Field was successfully created." )}
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @field.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @field = Field.find(params[:id])

    params[:field] = merge_hash(params[:field], "holes_attributes", "new_holes_attributes")
    params[:field] = merge_hash(params[:field], "hit_places_attributes", "new_hit_places_attributes")
    params[:field] = merge_hash(params[:field], "green_fees_attributes", "new_green_fees_attributes")
       
		@field.short_distance = 0 unless params[:field][:short_distance] 
		@field.very_short_distance = 0 unless params[:field][:very_short_distance] 
		@field.normal_distance = 0 unless params[:field][:normal_distance] 
		@field.long_distance = 0 unless params[:field][:long_distance] 
    respond_to do |format|
      if @field.update_attributes(params[:field])
        format.html { redirect_to('/club/edit_fields', :notice => "Field was successfully updated.") }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @field.errors, :status => :unprocessable_entity }
      end
    end
    
  end

  def destroy
    @field = Field.find(params[:id])
    @field.destroy

    respond_to do |format|
      format.html { redirect_to(edit_golf_club_path) }
      format.xml  { head :ok }
    end
  end

end
