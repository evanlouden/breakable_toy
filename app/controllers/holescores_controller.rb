class HolescoresController < ApplicationController
  def show
    @pars = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    @match = Match.find(params[:match_id])
    @opponent = (@match.hero == current_user ? @match.villain : @match.hero)
    if @match.started?(current_user)
      @holescore = Holescore.find(params[:id])
      @opponent_holescore = Holescore.find_by(match: @match, user: @opponent, hole: @holescore.hole)
      @holescore_start_value = (@holescore.gross_score.nil? ? @holescore.hole.par : @holescore.gross_score)
      @match_started = true
      @match.calculate_match_status
      user_match_status(@match)
      @previous_hole = Holescore.find_by(match: @match, user: current_user, hole: @holescore.hole.hole_number - 1)
      @next_hole = Holescore.find_by(match: @match, user: current_user, hole: @holescore.hole.hole_number + 1)
    else
      @match_started = false
      redirect_to @match
    end
  end

  def update
    @match = Match.find(params[:match_id])
    @holescore = Holescore.find(params[:id])
    @holescore.gross_score = params[:holescore][:gross_score]
    calculate_net_score(@holescore)
    @holescore.save
    user_match_status(@match)
    redirect_to match_holescore_path(@match, @holescore)
  end

  private

  def holescore_params
    params.require(:holescore).permit(
      :strokes,
      :gross_score,
      :net_score,
      :match_id
    ).merge(user_id: current_user.id).merge(hole_id: params[:hole_id]).merge(match_id: params[:match_id])
  end
end
