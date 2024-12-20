#! /usr/bin/env mix run
# run by: run/binance-tickers.exs

File.mkdir_p!("./_local")
target_file = Path.expand("./_local/run-man-tasks-#{Notioner.Utils.now()}.json")
taks = Notioner.Database.query(:run_man_tasks)
content = Jason.encode!(taks, pretty: true)
File.write(target_file, content)
IO.puts("# Write notion tickets into file: #{target_file}")
