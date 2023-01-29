class Project < ApplicationRecord
  acts_as_paranoid
  has_paper_trail

  validates_presence_of :title, :code
  belongs_to :project_lead, class_name: 'User', optional: true
  has_many :tasks
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
