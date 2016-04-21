class HolesController < ApplicationController
  before_action :authenticate_user!
  def create
    @course = Course.find(params[:course_id])
    @hole = Hole.new(hole_params)
    @hole.course = @course
    if @hole.save
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
    )
  end
end
