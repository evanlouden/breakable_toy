class HolesController < ApplicationController
  before_action :authenticate_user!
  def create
    @course = Course.find(params[:course_id])
    hole_numbers = []
    difficulty_numbers = []
    @course.holes.each do |hole|
      hole_numbers << hole.hole_number
      difficulty_numbers << hole.difficulty
    end
    @hole = Hole.new(hole_params)

    if hole_numbers.include?params[:hole][:hole_number].to_i
      flash[:alert] = "That hole has already been entered."
    elsif difficulty_numbers.include?params[:hole][:difficulty].to_i
      flash[:alert] = "That difficulty has already been entered."
    elsif @hole.save
      flash[:notice] = "Hole \##{@hole.hole_number} saved."
    else
      flash[:alert] = @hole.errors.full_messages.join(", ")
    end
    redirect_to course_path(@course)
  end

  private

  def hole_params
    params.require(:hole).permit(
      :hole_number,
      :par,
      :difficulty
    ).merge(course: Course.find(params[:course_id]))
  end
end
