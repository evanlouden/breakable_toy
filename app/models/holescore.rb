class Holescore < ActiveRecord::Base
  belongs_to :hole
  belongs_to :user
  belongs_to :match

  def assign_strokes(user, match)
    if user == match.hero && (1..18) === match.hero_adj_handicap
      if hole.difficulty <= match.hero_adj_handicap
        self.strokes = 1
      end
    elsif user == match.hero && match.hero_adj_handicap > 18
      if (hole.difficulty + 18) <= match.hero_adj_handicap
        self.strokes = 2
      else
        self.strokes = 1
      end
    end
    if user == match.villain && (1..18) === match.villain_adj_handicap
      if hole.difficulty <= match.villain_adj_handicap
        self.strokes = 1
      end
    elsif user == match.villain && match.villain_adj_handicap > 18
      if (hole.difficulty + 18) <= match.villain_adj_handicap
        self.strokes = 2
      else
        self.strokes = 1
      end
    end
  end
end
