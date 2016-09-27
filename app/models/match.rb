class Match < ActiveRecord::Base
  belongs_to :course
  has_many :holescores
  has_many :holes, through: :course

  belongs_to :hero, class_name: "User"
  belongs_to :villain, class_name: "User"


  def adjust_handicaps
    if self.hero.handicap < self.villain.handicap
      self.hero_adj_handicap = 0
      self.villain_adj_handicap = (self.villain.handicap - self.hero.handicap)
    elsif self.hero.handicap > self.villain.handicap
      self.villain_adj_handicap = 0
      self.hero_adj_handicap = (self.hero.handicap - self.villain.handicap)
    end
  end

  def calculate_match_status
    self.match_status = 0
    holes.order('hole_number').each do |hole|
      hero_holescore = holescores.find_by(user: hero, hole: hole)
      villain_holescore = holescores.find_by(user: villain, hole: hole)
      unless hero_holescore.nil? || villain_holescore.nil?
        if hero_holescore.gross_score.present? && villain_holescore.gross_score.present?
            self.match_status -= 1 if hero_holescore.net_score > villain_holescore.net_score
            self.match_status += 1 if hero_holescore.net_score < villain_holescore.net_score
        end
      end
    end
  end

  def opponent_and_adjusted_handicaps(user)
    @opponent = (hero == user ? villain : hero)
    @opponent_adjusted_handicap = (hero == user ? villain_adj_handicap : hero_adj_handicap)
    @adjusted_handicap = (hero == user ? hero_adj_handicap : villain_adj_handicap)
  end

  def started?(user)
    holescores.where.not(user: user).any?
  end
end
