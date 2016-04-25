class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :handicap, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :handicap, :password, :password_confirmation, :current_password) }
  end

  def adjust_handicaps(match)
    if match.hero.handicap < match.villain.handicap
      match.hero_adj_handicap = 0
      match.villain_adj_handicap = match.villain.handicap - match.hero.handicap
    elsif match.hero.handicap > match.villain.handicap
      match.villain_adj_handicap = 0
      match.hero_adj_handicap = match.hero.handicap - match.villain.handicap
    else
      match.hero_adj_handicap = match.hero.handicap
      match.villain_adj_handicap = match.villain.handicap
    end
  end

  def assign_strokes(holescore, user, match)
    if match.hero == user
      if match.hero_adj_handicap <= 18
        if holescore.hole.difficulty <= match.hero_adj_handicap
          holescore.strokes = 1
        else
          holescore.strokes = 0
        end
      elsif match.hero_adj_handicap > 18
        if (holescore.hole.difficulty + 18) <= match.hero_adj_handicap
          holescore.strokes = 2
        else
          holescore.strokes = 1
        end
      end
    else
      if match.villain_adj_handicap <= 18
        if holescore.hole.difficulty <= match.villain_adj_handicap
          holescore.strokes = 1
        else
          holescore.strokes = 0
        end
      elsif match.villain_adj_handicap > 18
        if (holescore.hole.difficulty + 18) <= match.villain_adj_handicap
          holescore.strokes = 2
        else
          holescore.strokes = 1
        end
      end
    end
  end

  def calculate_net_score(holescore)
    holescore.net_score = holescore.gross_score - holescore.strokes
  end

  def display_strokes(hole, user, match)
    if match.hero == user
      if match.hero_adj_handicap <= 18
        if hole.difficulty <= match.hero_adj_handicap
          @strokes = 1
        else
          @strokes = 0
        end
      elsif match.hero_adj_handicap > 18
        if (hole.difficulty + 18) <= match.hero_adj_handicap
          @strokes = 2
        else
          @strokes = 1
        end
      end
    else
      if match.villain_adj_handicap <= 18
        if hole.difficulty <= match.villain_adj_handicap
          @strokes = 1
        else
          @strokes = 0
        end
      elsif match.villain_adj_handicap > 18
        if (hole.difficulty + 18) <= match.villain_adj_handicap
          @strokes = 2
        else
          @strokes = 1
        end
      end
    end
  end

  def user_match_status(match)
    if match.match_status == 0
      @match_status = "All Square"
    elsif current_user == match.hero
      if match.match_status > 0
        @match_status = "#{match.match_status} UP"
      else
        @match_status = "#{match.match_status.abs} DOWN"
      end
    else
      if match.match_status < 0
        @match_status = "#{match.match_status.abs} UP"
      else
        @match_status = "#{match.match_status} DOWN"
      end
    end
    @match_status
  end

  def match_started?(match, user)
    holescores = Holescore.where(match: match)
    if holescores.where.not(user: user).empty?
      return false
    else
      return true
    end
  end

  def calculate_match_status(match)
    hero_holes = Holescore.where(match: match, user: match.hero).order('hole_id')
    villain_holes = Holescore.where(match: match, user: match.villain).order('hole_id')
    match.holes.count.times do |n|
      if hero_holes[n].gross_score.nil? || villain_holes[n].gross_score.nil?
        break
      else
        if hero_holes[n].net_score > villain_holes[n].net_score
          match.match_status -= 1
        elsif villain_holes[n].net_score > hero_holes[n].net_score
          match.match_status += 1
        end
      end
    end
  end
end
