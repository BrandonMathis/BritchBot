desc "Start polling Groupme Groups"
task :poll => [:environment] do
  Bot::Jobs.new.poll_all_groups
end
