module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "Sg Cloud"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def color_by_status(status)
    if status == 0
      "alert alert-danger"
    else
      "red"
    end
  end
end
