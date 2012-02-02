class Game < ActiveRecord::Base
  #has_many :hits, :dependent => :destroy
  has_many :pair_hits
  has_many :hits
	has_many :status_holes
  accepts_nested_attributes_for :hits
  accepts_nested_attributes_for :pair_hits
  belongs_to :user
  belongs_to :field
  has_many :holes, :through => :field

	
  def self.delete_with_stuff(game_id)
		game = Game.find(game_id)
		StatusHole.destroy game.status_holes.collect(&:id) if game.status_holes.any?
		Hit.destroy game.hits.collect(&:id) if game.hits.any?
		PairHit.destroy game.pair_hits.collect(&:id) if game.pair_hits.any?
		game.destroy
	end

end
