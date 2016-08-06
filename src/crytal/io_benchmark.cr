# io_benchmark.cr
require "benchmark"

io = MemoryIO.new

Benchmark.ips do |x|
  x.report("with to_s") do
    io << 123.to_s
    io.clear
  end

  x.report("without to_s") do
    io << 123
    io.clear
  end
end

# crystal io_benchmark.cr --release
# without to_s  51.82M (±11.93%)       fastest
#    with to_s  10.43M (± 8.33%)  4.97× slower
# 792k vs 864k
