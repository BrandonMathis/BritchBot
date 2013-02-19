desc "Start polling Groupme Groups"
task :start_poll => [:environment] do
  Bot::Jobs.new.poll_all_groups
  %x[script/delayed_job start]
end


desc "Stop polling Groupme Groups"
task :stop_poll => [:environment] do
  Bot::Jobs.new.poll_all_groups
  %x[script/delayed_job stop]
end
