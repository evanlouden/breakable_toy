class UsersController < ApplicationController
  def show
    @active_matches = Match.where("hero_id= ? or villain_id= ?", current_user, current_user).where(match_completed: false).order(created_at: :desc)
    @completed_matches = Match.where("hero_id= ? or villain_id= ?", current_user, current_user).where(match_completed: true).order(created_at: :desc)
    if @active_matches.count == 1
      redirect_to match_path(@active_matches.first)
    end
    if @active_matches.empty? && @completed_matches.empty?
      redirect_to courses_path
    end
  end
end
