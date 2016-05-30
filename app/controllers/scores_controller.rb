class ScoresController < ApplicationController
  def index
    @matches = Match.where('hero_id=? OR villain_id=?', current_user, current_user)
    @scores = []
    @matches.each do |match|
      match_info = {
        match: match,
        gross_score: calculate_round_score(match),
        esc_score: calculate_esc_score(match)
      }
      if match.hero == current_user
        match_info[:opponent] = match.villain
      else
        match_info[:opponent] = match.hero
      end
      @scores << match_info
    end
  end
end
