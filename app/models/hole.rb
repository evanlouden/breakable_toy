class Hole < ActiveRecord::Base
  belongs_to :course
  has_many :holescores

  validates :hole_number, presence: true, inclusion: { in: 1..18 }
  validates :difficulty, presence: true, inclusion: { in: 1..18 }
  validates :par, presence: true, inclusion: { in: 3..6 }

  def display_strokes(user, match)
    if match.hero == user
      if match.hero_adj_handicap <= 18
        if difficulty <= match.hero_adj_handicap
          strokes = 1
        else
          strokes = 0
        end
      elsif match.hero_adj_handicap > 18
        if (difficulty + 18) <= match.hero_adj_handicap
          strokes = 2
        else
          strokes = 1
        end
      end
    else
      if match.villain_adj_handicap <= 18
        if difficulty <= match.villain_adj_handicap
          strokes = 1
        else
          strokes = 0
        end
      elsif match.villain_adj_handicap > 18
        if (difficulty + 18) <= match.villain_adj_handicap
          strokes = 2
        else
          strokes = 1
        end
      end
    end
    strokes
  end
end
