task :get_groups => [:environment] do
  ap JSON.parse GroupMe.groups.body
end
