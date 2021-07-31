require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # deviseの日本語化
    config.i18n.default_locale = :ja
    # validateのエラーメッセージを日本語化するためにconfig/locales以下のymlを読ませる
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.yml').to_s]
    # タイムゾーンの変更
    config.time_zone = 'Asia/Tokyo'
    # RSpecテスト時に下記ドメインを許可
    config.hosts << '.example.com'

    config.generators do |g|
      g.stylesheets false
      g.helper false
      g.test_framework :rspec,
        fixture: true,
        view_specs: false,
        helper_specs: false
    end
  end
end
