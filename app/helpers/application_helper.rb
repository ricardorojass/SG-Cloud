module ApplicationHelper
  def color_by_status(status)
    if status == 0
      "alert alert-danger"
    else
      "red"
    end
  end
end
