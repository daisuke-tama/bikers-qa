require_relative "boot"

# sprocketsを除外するために一括requireをやめる
# require "rails/all"
require "rails"
# 除外すべきsprockets/railtie以外を記述
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "rails/test_unit/railtie"

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
    # Rails6系 DNSリバインディング攻撃からの保護 によりブロックされてしまうため、circleci上で使用許可するために記述
    config.hosts << "127.0.0.1"
    # herokuデプロイ後のHost許可
    config.hosts << "bikers-qa.herokuapp.com"

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
