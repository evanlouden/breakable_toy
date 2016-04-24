class Match < ActiveRecord::Base
  belongs_to :course
  has_many :holescores
  has_many :holes, through: :course

  belongs_to :hero, class_name: "User"
  belongs_to :villain, class_name: "User"
end
