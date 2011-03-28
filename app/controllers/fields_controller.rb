class FieldsController < ApplicationController

  def index
    @fields = Field.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @fields }
    end
  end

  def show
    @field = Field.find(params[:id])

    respond_to do |format|
      format.html
      format.xml  { render :xml => @field }
    end
  end

  def new
    @field = Field.new
    @new_hole_attributes_name = "holes_attributes[]"
    @new_hit_place_attributes_name = "hit_places_attributes[]"
    @new_green_fee_attributes_name = "green_fees_attributes[]"
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @field }
    end
  end

  def edit
    @field = Field.find(params[:id])
    
    @hole_attributes_name = "holes_attributes[]"
    @new_hole_attributes_name = (@field.holes) ? "new_holes_attributes[]" : @hole_attributes_name
    @hit_place_attributes_name = "hit_places_attributes[]"
    @new_hit_place_attributes_name = (@field.holes) ?  "new_hit_places_attributes[]" : @hit_place_attributes_name
    @green_fee_attributes_name = "green_fees_attributes[]"
    @new_green_fee_attributes_name = (@field.holes) ?  "new_green_fees_attributes[]" : @green_fee_attributes_name
     
    respond_to do |format|
      format.html
      format.xml  { render :xml => @field }
    end
  end

  def create
    @field = Field.new(params[:field])
    @field.golf_club_id = 1;
    
    respond_to do |format|
      if @field.save
        format.html { redirect_to(@field, :notice => 'Field was successfully created.') }
        format.xml  { render :xml => @field, :status => :created, :location => @field }
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
       
    respond_to do |format|
      if @field.update_attributes(params[:field])
        format.html { redirect_to(@field, :notice => 'Field was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @field.errors, :status => :unprocessable_entity }
      end
    end
    
  end

  def merge_hash field, holes_attributes_name, new_holes_attributes_name
    if field.include?(new_holes_attributes_name)
      max = field[holes_attributes_name].keys.max.to_i
      field[new_holes_attributes_name].each do |new_holes_attributes|
        max = max + 1
        field[holes_attributes_name][max] = new_holes_attributes
      end
      field.delete(new_holes_attributes_name)
    end
    field
  end

  def destroy
    @field = Field.find(params[:id])
    @field.destroy

    respond_to do |format|
      format.html { redirect_to(fields_url) }
      format.xml  { head :ok }
    end
  end
end
