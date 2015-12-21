require 'rails/railtie'
module InlineSvg
  class Railtie < ::Rails::Railtie
    initializer "inline_svg.action_view" do |app|
      ActiveSupport.on_load :action_view do
        require "inline_svg/action_view/helpers"
        include InlineSvg::ActionView::Helpers
      end
    end

    config.after_initialize do |app|
      InlineSvg.configure do |config|
        # In default Rails apps, this will be a fully operational
        # Sprockets::Environment instance
        app_assets = app.instance_variable_get(:@assets)
        config.asset_finder = app_assets if app_assets.respond_to? :find_asset
      end
    end
  end
end
