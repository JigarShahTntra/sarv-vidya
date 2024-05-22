class CourseWorker < BaseWorker
  def perform(topic)
    response = requests(course_title_prompt(topic))
    title_content = response
    course = Course.create(name: transform_title(title_content))
    LessonWorker.perform_async(course.id, course.name)
  end

  private

  def course_title_prompt(topic)
    "I am creating a course for #{topic} provide me title heading for the course which should be interesting to read and informative and in max 6 to 7 words."
  end
  def transform_title(title)
    title.gsub(/\"/, '')
  end
end