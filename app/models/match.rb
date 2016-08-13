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
end
