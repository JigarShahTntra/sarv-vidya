class LessonCreationWorker < BaseWorker
  def perform(course_id, lesson_name)
    course = Course.find_by(id: course_id)
    raw_content = requests(lesson_content_prompt(lesson_name))
    # content = transform_content_to_html(raw_content)
    course.lessons.create(name: lesson_name, content: raw_content)
  end

  private

  def lesson_content_prompt(name)
    "Create detailed understanding for #{name} and also describe every child points in detail."
  end

  def transformed_lesson_titles(lessons_content)
    lessons_content.gsub(/^\d+. /, '').split("\n")
  end
end
