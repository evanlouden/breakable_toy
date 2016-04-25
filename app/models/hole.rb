class Hole < ActiveRecord::Base
  belongs_to :course
  has_many :holescores

  validates :hole_number, presence: true, inclusion: { in: 1..18 }
  validates :difficulty, presence: true, inclusion: { in: 1..18 }
  validates :par, presence: true, inclusion: { in: 3..6 }
end
