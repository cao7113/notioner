#! /usr/bin/env mix run
# run by: run/binance-tickers.exs

File.mkdir_p!("./_local")
target_file = Path.expand("./_local/cache/run-man-tasks-#{Notioner.Utils.now()}.json")
data = Notioner.Database.query(:runner_tasks, page_size: 3)
content = Jason.encode!(data, pretty: true)
File.write(target_file, content)
IO.puts("# Write notion tickets into file: #{target_file}")
