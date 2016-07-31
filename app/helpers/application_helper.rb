module ApplicationHelper
  def body_classes
    unless response.status == 200
      "exception_#{response.status}"
    else
      [controller.controller_name,
       controller.action_name].compact.join(" ")
    end
  end
end