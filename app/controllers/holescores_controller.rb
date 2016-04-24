class HolescoresController < ApplicationController
  def create
    @match = Match.find(params[:match_id])
    @holescore = Holescore.new(holescore_params)
    assign_strokes(@holescore, current_user, @match)
    calculate_net_score(@holescore)
    @holescore.save
    redirect_to @holescore.match
  end

  def show
    @pars = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    @match = Match.find(params[:match_id])
    @holescores = Holescore.where(user: current_user, match: @match).order('hole_id')
    if match_started?(@match, current_user)
      @holescore = Holescore.find(params[:id])
      @holescores = Holescore.where(match: @match, hole: @holescore.hole)
      @holescores.each do |holescore|
        unless holescore.user == current_user
          @opponent_holescore = holescore
        end
      end
      @match_started = true
      calculate_match_status(@match)
      user_match_status(@match)
    else
      @match_stared = false
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
