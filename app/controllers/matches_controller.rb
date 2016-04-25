class MatchesController < ApplicationController
  before_action :authenticate_user!

  def create
    @match = Match.new(match_params)
    adjust_handicaps(@match)
    if @match.save
      flash[:notice] = "Match created. Play well."
    else
      flash[:alert] = @match.errors.full_messages.join(", ")
    end
    redirect_to match_path(@match)
  end

  def index
    @matches = Match.all
  end

  def new
    @match = Match.new
  end

  def show
    @match = Match.find(params[:id])
    if Holescore.where(match: @match, user: current_user).empty?
      @match.holes.count.times.each do |n|
        hole = Holescore.new(user: current_user, match: @match, hole_id: n + 1)
        assign_strokes(hole, current_user, @match)
        hole.save
      end
    end
    @holescores = Holescore.where(user: current_user, match: @match).order('hole_id')
    @match_started = match_started?(@match, current_user)
    calculate_match_status(@match)
    user_match_status(@match)
  end

  private

  def match_params
    params.require(:match).permit(
      :villain_id,
      :course_id,
    ).merge(hero_id: current_user.id)
  end
end
