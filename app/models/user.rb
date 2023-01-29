class User < ApplicationRecord
  has_secure_password
  acts_as_paranoid
  has_paper_trail

  validates_presence_of :first_name, :last_name
  VALID_EMAIL_REGEX = /\A[^@\s]+@([^@\s]+\.)+[^@\W]+\z/
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
  has_many :managing_projects, class_name: 'Project', foreign_key: 'project_lead_id'
  has_many :tasks, foreign_key: 'assignee_id'

  def full_name
    "#{first_name} #{last_name}"
  end
end

# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  deleted_at      :datetime
#  email           :string
#  first_name      :string
#  last_name       :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
