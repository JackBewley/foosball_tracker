class Team < ActiveRecord::Base
  belongs_to :game
  
  has_many :players, :dependent => :destroy
  
  accepts_nested_attributes_for :players
  
  validates_numericality_of :goals, :only_integer => true, :minimum => 0
  
  validates_each :goals do |record, attr, value|
    if record.is_winner?
      record.errors.add attr, "must have at least 10 goals to win" unless value >= 10
    end  
  end
  
  def overtime?
    is_winner ? goals > 10 : goals > 8
  end
  
  def pairings
    self.players.sort_by{|i| i.user_id}.flatten.map(&:user).to_a
    # self.players.sort_by{|i| i.user_id}.flatten.map(&:user).map(&:name).to_a
    # user_list = self.players.sort_by{|i| i.user_id}.flatten.map(&:user).map(&:name).to_a    
    # puts user_list
    # h = Hash.new(0)
    # user_list.each { | v | h.store(v, h[v]+1) }
    # h
    #.to_a.sort_by(&:last).reverse
    
  end
  
end
