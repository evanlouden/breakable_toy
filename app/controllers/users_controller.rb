class UsersController < ApplicationController
  def show
    @created_matches = Match.where(hero: current_user)
    @invited_matches = Match.where(villain: current_user)
  end
end
