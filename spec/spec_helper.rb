# encoding: utf-8
ENV["RAILS_ENV"] ||= 'test'
require 'rspec/rails'

RSpec.configure do |config|

  config.include FactoryGirl::Syntax::Methods

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  # Output format
  config.color_enabled = true
  config.tty = true
  config.formatter = :documentation

  ActiveSupport::Deprecation.silenced = true

  if Mug.present?
    config.after(:all) do
      Object.send(:remove_const, :Mug)
      Object.send(:remove_const, :Company)
    end
  end
end
