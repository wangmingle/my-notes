# tail -f production.log | ruby slow.rb 1000 大于1000秒
# cat     production.log | ruby slow.rb 1000 大于1000秒

time = ARGV.first || "1000"
time = time.to_f

while line = STDIN.gets
  result = /duration=([\d.]+)/.match(line)
  if result
    duration = $1
    if duration.to_f > time
      puts line
    end
  end
end
