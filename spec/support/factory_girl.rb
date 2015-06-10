RSpec.configure do |config|
  # Makes the method `fixture_file_upload` available
  include ActionDispatch::TestProcess
  
  config.include FactoryGirl::Syntax::Methods
end
