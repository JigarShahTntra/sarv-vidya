class TextService < BaseAiServices

  attr_reader :topic
  def initialize(prompt)
    @topic = prompt
  end

  def generate
    ::CourseWorker.perform_async(topic)
  end
end
