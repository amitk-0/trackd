require "test_helper"

class TaskTest < ActiveSupport::TestCase
  fixtures :tasks
  test 'invalid without summary' do
    task = tasks(:task_one)
    task.summary = nil
    assert_not task.valid?
    assert_equal task.errors.full_messages.first, "Summary can't be blank"
  end

  test 'invalid with short summary' do
    task = tasks(:task_one)
    task.summary = 'Short'
    assert_not task.valid?
    assert_equal task.errors.full_messages.first, 'Summary is too short (minimum is 8 characters)'
  end

  test 'invalid without description' do
    task = tasks(:task_two)
    task.description = nil
    assert_not task.valid?
    assert_equal task.errors.full_messages.first, "Description can't be blank"
  end

  test 'invalid with short description' do
    task = tasks(:task_two)
    task.description = 'abcd'
    assert_not task.valid?
    assert_equal task.errors.full_messages.first, 'Description is too short (minimum is 15 characters)'
  end

end

# == Schema Information
#
# Table name: tasks
#
#  id              :integer          not null, primary key
#  deleted_at      :datetime
#  description     :string
#  status          :integer          default("open"), not null
#  summary         :string
#  task_identifier :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  assignee_id     :integer
#  created_by_id   :integer          not null
#  project_id      :integer          not null
#
# Indexes
#
#  index_tasks_on_assignee_id    (assignee_id)
#  index_tasks_on_created_by_id  (created_by_id)
#  index_tasks_on_project_id     (project_id)
#
# Foreign Keys
#
#  assignee_id    (assignee_id => users.id)
#  created_by_id  (created_by_id => users.id)
#  project_id     (project_id => projects.id)
#
