require Rails.root.join 'lib', 'api'

task :get_groups do
  ap GroupMe.groups.body
end
