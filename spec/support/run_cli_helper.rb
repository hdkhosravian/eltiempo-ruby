
# frozen_string_literal: true

module RunCliHelper
  def run_cli(file, *args)
    system("#{file} #{args.join(' ')}")
  end
end

RSpec.configure do |config|
  config.include RunCliHelper
end
  