require Rails.root.join 'lib', 'api'
require 'json'

task :get_groups do
  ap JSON.parse GroupMe.groups.body
end
