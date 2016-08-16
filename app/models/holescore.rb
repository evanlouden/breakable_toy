class Holescore < ActiveRecord::Base
  belongs_to :hole
  belongs_to :user
  belongs_to :match

  def assign_strokes(user, match)
    if user == match.hero && match.hero_adj_handicap > 0 && match.hero_adj_handicap <= 18
      self.strokes = 1 if hole.difficulty <= match.hero_adj_handicap
    elsif user == match.hero && match.hero_adj_handicap > 18
      if (hole.difficulty + 18) <= match.hero_adj_handicap
        self.strokes = 2
      else
        binding.pry
        self.strokes = 1
      end
    end
    if user == match.villain && match.villain_adj_handicap > 0 && match.villain_adj_handicap <= 18
      self.strokes = 1 if hole.difficulty <= match.villain_adj_handicap
    elsif user == match.villain && match.villain_adj_handicap > 18
      if (hole.difficulty + 18) <= match.villain_adj_handicap
        self.strokes = 2
      else
        self.strokes = 1
      end
    end
  end
end
