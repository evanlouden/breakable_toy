class CoursesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  def create
    @course = Course.new(course_params)
    if @course.save
      flash[:notice] = @course.name + " has been added."
      redirect_to @course
    else
      flash[:alert] = @course.errors.full_messages.join(", ")
      redirect_to new_course_path
    end
  end

  def search
   @courses = Course.search(params[:query])
   if @courses.empty?
     flash[:alert] = "Sorry, but we couldn't find any orders matching '#{params[:query]}'"
   end
     render :index
  end

  def index
    @courses = Course.all.order(id: :desc).limit(10)
  end

  def new
    @course = Course.new
    @state_collection = Course::STATES
  end

  def show
    @course = Course.find(params[:id])
    @hole = Hole.new
  end

  private
  def course_params
    params.require(:course).permit(
      :name,
      :address,
      :city,
      :state,
      :zip
    )
  end
end
