class HomeController < ApplicationController
  before_action :set_course, only: [:lessons, :lesson, :course]

  def index
    @courses = Course.all
  end

  def create
    TextService.new(params[:topic]).generate
    redirect_to root_path, notice: 'Course will be available in some time.'
  end

  def lessons
    @lessons = @course.lessons
  end
  
  def lesson
    @lesson = @course.lessons.find_by(id: params['lesson_id'])
  end

  def course
    @course.destroy
    redirect_to root_path
  end

  private

  def set_course
    @course = Course.find_by(id: params[:id])
  end
end
