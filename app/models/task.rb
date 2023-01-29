class Task < ApplicationRecord
  acts_as_paranoid
  has_paper_trail

  validates :summary, presence: true, length: { minimum: 8 }
  validates :description, presence: true, length: { minimum: 15 }

  belongs_to :project
  enum status: { open: 0, to_do: 1, in_progress: 2, done: 3 }
  belongs_to :assignee, class_name: 'User', optional: true
  belongs_to :created_by, class_name: 'User', optional: true
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
