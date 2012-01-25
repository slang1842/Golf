class StatusHole < ActiveRecord::Base

belongs_to :game

def self.fetch_finished_holes(user_id)
		games = Game.where(:user_id => user_id)
		game_id_arr = []
		games.each {|game| game_id_arr << game.id}
		holes = where("status_holes.completeness = 2 AND status_holes.game_id IN(?)", game_id_arr)
		return holes
	end


def self.fetch_last_hole(user_id)
		games = Game.where(:user_id => user_id)
		game_id_arr = []
		games.each {|game| game_id_arr << game.id}
		hole = where("status_holes.completeness = 2 AND status_holes.game_id IN(?)", game_id_arr).order("status_holes.updated_at desc").first
		if hole == nil
			return false
		else
		return hole
		end
	end

end
