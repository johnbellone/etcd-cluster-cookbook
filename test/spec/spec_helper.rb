require 'chefspec'
require 'chefspec/berkshelf'
require 'chefspec/cacher'

RSpec.configure do |c|
  c.platform = 'centos'
  c.version = '7.1'
end
