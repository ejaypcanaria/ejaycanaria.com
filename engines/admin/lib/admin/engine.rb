module Admin
  class Engine < ::Rails::Engine
    isolate_namespace Admin

    config.generators do |g|
      g.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        helper_specs: true,
        routing_specs: false,
        controller_specs: true,
        request_specs: false

      g.fixture_replacement :factory_girl, dir: "spec/factories"
    end
  end
end
