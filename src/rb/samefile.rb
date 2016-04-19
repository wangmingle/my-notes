# 找出一样的文件

path = '/Volumes/TOSHIBA EXT'

# path => [name,size]
store = {}
size_h = {}
name_h = {}
sames = {}
hash = { s: store, sh: size_h, nh: name_h, sa: sames}

FILTERS = Hash[['.','..','System Volume Information','$RECYCLE.BIN','dev','work','学习','资 产','file','pic'].map { |e| [e,true] }]

def ignore?(file)
  FILTERS[file] || file =~ /^\./
end
def set_same(hash,p1,p2)
  hash[:sa][p1] = (hash[:sa][p1] || []) + [p2]
end
def size_save(p, p2, size, hash)
  if hash[:sh][size] && size != 0
    set_same(hash, hash[:sh][size].first, p2)
  end
  hash[:sh][size] = (hash[:sh][size] || []) + [p2]
end
def name_save(p,p2, name,hash)
  if hash[:nh][name]
    set_same(hash, hash[:nh][name].first, p2)
  end
  hash[:nh][p] = (hash[:nh][p] || []) + [p2]
end

def compare path, hash
  Dir.entries(path).each do |p|
    p2 = "#{path}/#{p}"
    if File.directory?(p2)
      unless ignore?(p)
        compare(p2,hash)
      end
    else
      size = File.stat(p2).size rescue 0
      hash[:s][p2] = [p2, size]
      size_save(p, p2, size, hash)
      name_save(p,p2, p,hash)
    end
  end
end

compare path, hash

hash[:sa].map { |k,v| puts ([k]+v).join("\n") + " ========="  }
