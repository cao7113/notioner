#! /usr/bin/env mix run
# run by: run/binance-tickers.exs

File.mkdir_p!("./_local")
target_file = Path.expand("./_local/run-man-projects-#{Notioner.Utils.now()}.json")
data = Notioner.all_projects()
content = Jason.encode!(data, pretty: true)
File.write(target_file, content)
IO.puts("# Write notion tickets into file: #{target_file}")
