tips:


https://github.com/franzejr/best-ruby

======
```ruby
# class method & instance method
 class Foo
   def self.bar
     "foo bar"
   end  
   delegate :bar, to: 'self.class'
 end  
# Hash[ object ] → new_hash
Hash[%i(web android ios).map { |e| [e,true] }]  #=> { web:true, android: true, ios: true}
Hash[[:a, :b, :c].map.with_index(0).to_a] # => {:a=>0, :b=>1, :c=>2}
Array(1) #=> [1]
Array([1]) #=> [1]

#lock
REDIS.incr(key) > 1 ? true : (REDIS.expire(key, PUSH_REDUPLICATE_EXPIRE_TIME) && false)
```