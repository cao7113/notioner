#! /usr/bin/env mix run
# run by: run/binance-tickers.exs

File.mkdir_p!("./_local")
target_file = Path.expand("./_local/reading-list-db-schema.json")
data = Notioner.Database.get(:reading_list)
content = Jason.encode!(data, pretty: true)
File.write(target_file, content)
IO.puts("# Write notion tickets into file: #{target_file}")
