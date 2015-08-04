def kill_process(port, kill_level='')
  kill_level = "-s #{kill_level}" unless kill_level.empty? || kill_level.to_i().real?
  run_process("kill #{kill_level} $(lsof -wni tcp:#{port} |  xargs echo | cut -d \\  -f 11)", '.')
end

Given(/^I have a rails app in "(.*)"$/) do |app|
  #expect folder structure of a rails app: config, app, etc
  @app_path = @hw_path.to_s + '/' + app
  expect(Dir).to exist(@app_path)
end

Given(/^I have a sinatra app in "(.*)"$/) do |app|
  #expect folder structure of a rails app: config, app, etc
  @app_path = @hw_path.to_s + '/' + app
  expect(Dir).to exist(@app_path)
end


Given(/^I run a rails server$/) do
  pid = Process.fork {
    run_process('rails s', @app_path)
  }
  Process.detach(pid)

  #TODO arbitrary, use a timeout?
  # Gets Net::HTTP::Persistent::Error on local if no timeout, increasing for travis
  # Also gets that with connection refused if there is no javascript runtime ie therubyracer in rottenpotatoes/Gemfile
  # Net::HTTP::Persistent::Error:
  #   +       connection refused: localhost:3000

  sleep 10

end

Given(/^I run a sinatra server$/) do
  pid = Process.fork {
    run_process('rackup', @app_path)
  }
  Process.detach(pid)

  #TODO arbitrary, use a timeout?
  # Gets Net::HTTP::Persistent::Error on local if no timeout, increasing for travis
  # Also gets that with connection refused if there is no javascript runtime ie therubyracer in rottenpotatoes/Gemfile
  # Net::HTTP::Persistent::Error:
  #   +       connection refused: localhost:3000

  sleep 10

end

Given(/^I kill any process using port "([^"]*)"$/) do |port|
  # try progressively more forceful shutdown requests
  if `lsof -wni tcp:#{port}` != ''
    puts "Killing a process that was using port #{port}"
    kill_process(port)
  end
  if `lsof -wni tcp:#{port}` != ''
    puts " ..escalate to SIGINT, equivalent of Ctrl+C"
    kill_process(port,'-2')
  end
  if `lsof -wni tcp:#{port}` != ''
    puts " ..escalate to SIGKILL, equivalent of kill -9"
    kill_process(port,'-9')
  end
  expect(`lsof -wni tcp:#{port}`).to eq('')
end


And(/^I install the app$/) do
  run_process('bundle install', @app_path)
  #newest version of rails outputs more than simply "your bundle is complete" thus this requirement has been removed
  #expect(@test_output).to match /Your bundle is complete/
end
