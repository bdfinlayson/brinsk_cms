class UserDecorator < Draper::Decorator
  delegate_all

  def inbox_tasks
    object.tasks.where(state: 'inbox')
  end

  def working_tasks
    object.tasks.where(state: 'working')
  end

  def completed_tasks
    object.tasks.where(state: 'completed')
  end
end
