class Holescore < ActiveRecord::Base
  belongs_to :hole
  belongs_to :user
  belongs_to :match

  validates :strokes, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :gross_score, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :net_score, presence: true, numericality: { greater_than_or_equal_to: -1 }

  def assign_strokes(user, hole)
    if user.handicap <= 18
      if hole.difficulty <= user.handicap
        holescore.strokes += 1
      end
    else
      if hole.difficuly + 18 <+ user.handicap
        holescore.strokes += 2
      else
        holescore.strokes += 1
      end
    end
  end
end
