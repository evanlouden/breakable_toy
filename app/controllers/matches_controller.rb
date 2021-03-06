class MatchesController < ApplicationController
  before_action :authenticate_user!

  def create
    @match = Match.new(match_params)
    @match.adjust_handicaps
    if @match.save
      flash[:notice] = "Match created. Play well."
    else
      flash[:alert] = @match.errors.full_messages.join(", ")
    end
    redirect_to match_path(@match)
  end

  def destroy
    @match = Match.find(params[:id])
    @match.destroy
    redirect_to user_path
  end

  def new
    @match = Match.new
    @available_opponents = []
    @sorted_users = User.all.sort { |x, y| x.username.casecmp(y.username) }
    @sorted_users.each do |user|
      unless user.id == 1 || user == current_user
        @available_opponents << user
      end
    end
    @sorted_courses = Course.all.sort { |x, y| x.name.casecmp(y.name) }
    @courses_available_for_ghost = []
    Match.all.each do |match|
      unless @courses_available_for_ghost.include?(match.course)
        @courses_available_for_ghost << match.course
      end
    end
  end

  def show
    @match = Match.find(params[:id])
    if Holescore.where(match: @match, user: current_user).empty?
      @match.holes.count.times.each do |n|
        hole = Holescore.new(user: current_user, match: @match, hole_id: n + 1)
        hole.assign_strokes(current_user, @match)
        hole.save
      end
    end
    @holescores = Holescore.where(user: current_user, match: @match).order('hole_id')
    @match_started = @match.started?(current_user)
    @opponent = (@match.hero == current_user ? @match.villain : @match.hero)
    @opponent_adjusted_handicap = (@match.hero == current_user ? @match.villain_adj_handicap : @match.hero_adj_handicap)
    @adjusted_handicap = (@match.hero == current_user ? @match.hero_adj_handicap : @match.villain_adj_handicap)
    @match.calculate_match_status
    user_match_status(@match)
  end

  def ghost
    @course = Course.find(params[:course_id])
    @ghost_match = Match.where(course: @course).sample
    @ghost_user = User.find(1)
    @random_user = [@ghost_match.hero, @ghost_match.villain].sample
    @ghost_user.update_attribute(:handicap, @random_user.handicap)
    @holescores = Holescore.where(user: @random_user, match: @ghost_match).order('hole_id')
    @match = Match.new(hero: current_user, villain: @ghost_user , course: @course)
    @match.adjust_handicaps
    @match.save
    @holescores.each do |holescore|
      hole = Holescore.new(user: @ghost_user, match: @match, hole_id: holescore.hole_id, gross_score: holescore.gross_score)
      hole.assign_strokes(current_user, @match)
      calculate_net_score(hole)
      hole.save
    end
    redirect_to @match
  end

  def update
    @match = Match.find(params[:id])
    @match.match_completed = true
    @match.save
    Holescore.where(match: @match, gross_score: nil).delete_all
    redirect_to root_path
  end

  private

  def match_params
    params.require(:match).permit(
      :villain_id,
      :course_id,
    ).merge(hero_id: current_user.id)
  end
end
