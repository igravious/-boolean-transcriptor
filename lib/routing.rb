# https://stackoverflow.com/questions/16720514/how-to-use-url-helpers-in-lib-modules-and-set-host-for-multiple-environments

module Routing
  extend ActiveSupport::Concern
  include Rails.application.routes.url_helpers

  included do
    def default_url_options
      ActionMailer::Base.default_url_options
    end
  end
end

