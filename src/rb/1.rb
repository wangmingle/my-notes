# Enter your code here. Read input from STDIN. Print output to STDOUT
# s1 = '4 4 1'.split.map(&:to_i)
# s2 = '1 2 3 4'.split.map(&:to_i)
# s3 = '5 6 7 8'.split.map(&:to_i)
# s4 = '9 10 11 12'.split.map(&:to_i)
# s5 = '13 14 15 16'.split.map(&:to_i)

s1 = '5 4 7'.split.map(&:to_i)
s2 = '1 2 3 4'.split.map(&:to_i)
s3 = '7 8 9 10'.split.map(&:to_i)
s4 = '13 14 15 16'.split.map(&:to_i)
s5 = '19 20 21 22'.split.map(&:to_i)
s6 = '25 26 27 28'.split.map(&:to_i)

# row,col,R = s1
row,col,R = gets.split.map(&:to_i)
a = []
row.times do |i|
    # a[i] = eval("s#{i+2}")
    a[i] = gets.split.map(&:to_i)[0..col]
end

# row.times do |i|
#   puts a[i].join(' ')
# end

q = []
n,j,k = 0,0,0

def arr_to_line(arr,x,y,r,c)
  line = []
  line += arr[x][y..(c-y-1)]
  # puts "1: #{line.inspect}"
  ((x+1)..(r-x-1)).each do |_x|
    # puts "2: #{_x} / #{c-y-1} / #{arr[_x]} / #{arr[_x][c-y-1]}"
    line << arr[_x][c-y-1]
  end
  # puts "3: #{line.inspect}"
  (y..(c-y-2)).to_a.reverse.each do |_y|
    line << arr[r-x-1][_y]
  end
  # puts "4: #{line.inspect}"
  ((x+1)..(r-x-2)).to_a.reverse.each do |_x|
    line << arr[_x][y]
  end
  # puts "5: #{line.inspect}"
  line
end

# transformat
([row,col].min / 2).times do |i|
  q << arr_to_line(a,i,i,row,col)
end

# rotation
# puts q.inspect
q = q.map do |line|
  k = R % line.size
  e = line.shift(k)
  line = line + e
end
# puts q.inspect

# transformat reverse
def queue_to_arr(arr, que, i , r, c)
  x,y = i,i
  
  t = c - (2 * i)
  t.times do |k|
    arr[x][(y = i + k)] = que[i].shift
  end
  
  t = r - 2*i - 1
  t.times do |k|
    arr[x+=1][y] = que[i].shift
  end
  
  t = c - 2*i - 1
  t.times do |k|
    arr[x][y-=1] = que[i].shift
  end
  
  t = r - 2*i -2
  t.times do |k|
    arr[x-=1][y] = que[i].shift
  end
end

# puts q.inspect

([row,col].min / 2).times do |i|
  queue_to_arr(a,q,i,row,col)
end

row.times do |i|
  puts a[i].join(' ') 
end




