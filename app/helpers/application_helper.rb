module ApplicationHelper
  def flash_class(level = :notice)
    classes = {
      notice: 'alert-info',
      success: 'alert-success',
      error: 'alert-danger',
      alert: 'alert-warning'
    }
    classes[level.to_sym]
  end

end
