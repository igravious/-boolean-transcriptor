require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module PetulantOctoLana
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
 
    ### only applies to produciton - see app/assets/javascripts/application.js for the rest
    #
    # for each controller that has a js in app/assets/javascripts
    config.assets.precompile += ['items.js', 'scans.js', 'transcriptions.js',  'search.js',  'notes.js',  'collection_pages.js',  'desk_pages.js']
    # for each controller that has a css in app/assets/stylesheets
    config.assets.precompile += [                        'transcriptions.css', 'search.css', 'notes.css', 'collection_pages.css', 'desk_pages.css']
    # for each vendor javascript used
    config.assets.precompile += ['jquery.bxslider.min.js', 'jquery.lazyload.js', 'jquery.cookie.js', 'jquery.simple.tree.menu.js', 'jquery.fs.zoomer.js', 'jquery.colorpicker.js', 'jquery-ui.js', 'easeljs.min.js']
    # for each vendor stylesheet used
    config.assets.precompile += ['jquery.bxslider.css', 'jquery.simple.tree.menu.css', 'jquery.fs.zoomer.css', 'jquery.colorpicker.css', 'jquery-ui.min.css']
    # and their images, a bit shotgun
    config.assets.precompile += %w[*.png *.jpg *.jpeg *.gif *.woff *.ttf *.svg]
  end
end
