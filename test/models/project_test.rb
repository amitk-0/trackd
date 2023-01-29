require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  fixtures :projects
  test 'invalid without title' do
    project = projects(:project_one)
    project.title = nil
    assert_not project.valid?
    assert_equal project.errors.full_messages.first, "Title can't be blank"
  end

  test 'invalid with short title' do
    project = projects(:project_one)
    project.title = 'ab'
    assert_not project.valid?
    assert_equal project.errors.full_messages.first, 'Title is too short (minimum is 4 characters)'
  end

  test 'invalid without code' do
    project = projects(:project_two)
    project.code = nil
    assert_not project.valid?
    assert_equal project.errors.full_messages.first, "Code can't be blank"
  end

  test 'invalid with large title' do
    project = projects(:project_two)
    project.title = 'ab'
    assert_not project.valid?
    assert_equal project.errors.full_messages.first, 'Title is too short (minimum is 4 characters)'
  end

end

# == Schema Information
#
# Table name: projects
#
#  id              :integer          not null, primary key
#  code            :string
#  deleted_at      :datetime
#  description     :string
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  project_lead_id :integer
#
# Indexes
#
#  index_projects_on_project_lead_id  (project_lead_id)
#
# Foreign Keys
#
#  project_lead_id  (project_lead_id => users.id)
#
