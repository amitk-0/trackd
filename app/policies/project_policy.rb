class ProjectPolicy
  attr_reader :user, :project

  def initialize(user, project)
    @user = user
    @post = project
  end

  def show?
    @user.is_admin?
  end

  def project_tasks?
    show?
  end

  def update?
    @user.is_admin?
  end

  def edit?
    update?
  end

  def create?
    @user.is_admin?
  end

  def new?
    create?
  end
end
