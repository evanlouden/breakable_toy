class Holescore < ActiveRecord::Base
  belongs_to :hole
  belongs_to :user
  belongs_to :match
end
