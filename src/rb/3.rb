x_arr = (1..9999).to_a
puts x_arr.size
puts x_arr[0]
puts x_arr[9998]

h = {}

x_arr.each do |x|
  y = (x * 8) % 9999
  puts h[y] if h[y]
  h[y] = true
end

puts h.size