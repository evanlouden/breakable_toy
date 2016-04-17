class Match < ActiveRecord::Base
  belongs_to :course

  belongs_to :hero, class_name: "User"
  belongs_to :villain, class_name: "User"
end
