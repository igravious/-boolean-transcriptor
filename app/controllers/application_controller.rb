class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action do |controller|
    if member_signed_in? and current_member.special?
      admin_path_str = "admin_#{controller.controller_name}_path"
      begin
        @admin_panel = controller.send(admin_path_str)
        Rails.logger.info("before_action in #{__FILE__}")
        Rails.logger.info(@admin_panel)
        Rails.logger.info(config.relative_url_root)
        Rails.logger.info(ENV["RAILS_RELATIVE_URL_ROOT"])
        @admin_panel = @admin_panel[(config.relative_url_root.length)..-1]
        Rails.logger.info(@admin_panel)
        Rails.logger.info("***")
      rescue Exception => e
        flash.now[:alert] = "Haven't created an admin one of these yet: #{e.message}"
        @admin_panel = {text: ""}
      end
    else
      @admin_panel = {text: ""}
    end
  end

  # https://stackoverflow.com/questions/914226/rails-set-a-common-instance-variable-across-several-controller-actions
  
  # need to cache these and only change/recheck them when a scan gets accepted

  before_filter :do_common_stuff
  def do_common_stuff
    @total_items_possible ||= Item.total_possible.length
    @total_items_accepted ||= Item.total_accepted.length

    @total_tx_possible ||= Scan.total_possible.length
    @total_tx_accepted ||= Scan.total_accepted.length
  end

  # https://github.com/airblade/paper_trail

  def user_for_paper_trail
    current_member
  end

  # https://github.com/plataformatec/devise/wiki/How-To:-Redirect-back-to-current-page-after-sign-in,-sign-out,-sign-up,-update

  def after_sign_in_path_for(resource)
    # members_locked_scans_path
    # disabled for the moment until large image served not in history
    # get_location || root_path
    root_path
  end

  after_filter :set_location

  private
  
  def set_location
    # store last url as long as it isn't a /members path
    session[:return_to] = request.fullpath unless (request.fullpath =~ /\/members/ or request.xhr?)
  end

  def get_location
    session[:return_to]
  end

  def unset_location
    session.delete(:return_to)
  end

  def nullify_location
    session[:return_to] = nil
  end
end
