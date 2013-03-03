desc "Start polling Groupme Groups"
task :start_poll => [:environment] do
  Bot::Jobs.new.poll
  %x[script/delayed_job start]
end


desc "Stop polling Groupme Groups"
task :stop_poll => [:environment] do
  Delayed::Job.destroy_all
  %x[script/delayed_job stop]
end
