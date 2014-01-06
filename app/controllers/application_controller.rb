class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_up_admin_panel
 
  private
 
  def set_up_admin_panel
    if user_signed_in? and current_user.special?
      admin_path = "admin/#{:controller}"
      begin
        @admin_panel = controller.send(admin_path)
      rescue Exception => e
        flash[:alert] = "Oh fiddlesticks: #{e.message}"
        @admin_panel = {text: ""}
      end
    else
      @admin_panel = {text: ""}
    end
  end
end
