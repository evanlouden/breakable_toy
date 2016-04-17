class User < ActiveRecord::Base
  has_many :matches
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :handicap, presence: true, inclusion: { in: 0..36 }
end
