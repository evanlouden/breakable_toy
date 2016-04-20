class MatchesController < ApplicationController
  before_filter :authenticate_user!
  def new
    @match = Match.new
  end

  def create
    @match = Match.new
    @match.hero = current_user
    @villain = User.find_by!(email: params[:match][:villain])
    @match.villain = @villain
    @match.course_id = params[:match][:course_id]
    @match.match_status = 0
    @match.save
  end

  private

  def match_params
    params.require(:course).permit(
      :villain,
      :course
    )
  end
end
