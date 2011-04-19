class StatisticController < ApplicationController

  def calculate_statistics
    @all_users = Users.all
    puts @all_users
  end

end
