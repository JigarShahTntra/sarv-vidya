class LessonWorker < BaseWorker
  def perform(course_id, course_name)
    lessons_titles = requests(course_lessons_prompt(course_name))
    transformed_lesson_titles(lessons_titles).each do |lesson|
      LessonCreationWorker.perform_async(course_id, lesson)
    end
  end

  private

  def course_lessons_prompt(title)
    "I want you to create 10 lessons for #{title} in max 6 to 7 words."
  end

  def lesson_content_prompt(name)
    "I want you to create detailed content for #{name} which should be very detailed and in two pages with best formatting."
  end

  def transformed_lesson_titles(lessons_content)
    lessons_content.gsub(/^\d+. /, '').split("\n")
  end
end
