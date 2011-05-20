class GameStatisticsController < ApplicationController
  # GET /game_statistics
  # GET /game_statistics.xml
  def index
    @game_statistics = GameStatistic.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @game_statistics }
    end
  end

  # GET /game_statistics/1
  # GET /game_statistics/1.xml
  def show
    @game_statistic = GameStatistic.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @game_statistic }
    end
  end

  # GET /game_statistics/new
  # GET /game_statistics/new.xml
  def new
    @game_statistic = GameStatistic.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @game_statistic }
    end
  end

  # GET /game_statistics/1/edit
  def edit
    @game_statistic = GameStatistic.find(params[:id])
  end

  # POST /game_statistics
  # POST /game_statistics.xml
  def create
    @game_statistic = GameStatistic.new(params[:game_statistic])

    respond_to do |format|
      if @game_statistic.save
        format.html { redirect_to(@game_statistic, :notice => 'Game statistic was successfully created.') }
        format.xml  { render :xml => @game_statistic, :status => :created, :location => @game_statistic }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @game_statistic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /game_statistics/1
  # PUT /game_statistics/1.xml
  def update
    @game_statistic = GameStatistic.find(params[:id])

    respond_to do |format|
      if @game_statistic.update_attributes(params[:game_statistic])
        format.html { redirect_to(@game_statistic, :notice => 'Game statistic was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @game_statistic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /game_statistics/1
  # DELETE /game_statistics/1.xml
  def destroy
    @game_statistic = GameStatistic.find(params[:id])
    @game_statistic.destroy

    respond_to do |format|
      format.html { redirect_to(game_statistics_url) }
      format.xml  { head :ok }
    end
  end
end
