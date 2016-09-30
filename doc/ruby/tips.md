tips:

--------

####  constant
```
ALERTS = {
  'info' => InfoAlert,
  'warn' => WarnAlert,
  'error' => ErrorAlert
}

class AlertsController < ApplicationController
  def create
    ALERTS.fetch(params[:alert][:type])).new(params[:alert][:value]))

    # ... other work
    # render page
  end
end
```

# index_by
```
people_by_id = Person.find(ids).index_by(&:id) # Gives you a hash indexed by ID
ids.collect {|id| people_by_id[id] }
```
# Bad. You will add this gem to the production environment even if you are not using it there
gem 'rubocop'

# Good
gem 'rubocop', group: :development
```

```ruby
class A
  private # 后的self.foo 并不是私有方法
  def self.foo
    puts "foo"
  end
end
A.foo  # foo => ok

```
https://github.com/franzejr/best-ruby

======
```ruby
# rails
emum :status, {on: 1, off:2}
status = :on
save    # status = nil
self.status = :on
save    # status = 1
```
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

# test valid
# https://www.sitepoint.com/quick-tip-dry-up-your-model-validations-tests
def test_should_require_customer_email
    site = Site.new
    refute site.valid?
    refute site.save
    assert_operator site.errors.count, :>, 0
    assert site.errors.messages.include?(:customer_email)
    assert site.errors.messages[:customer_email].include?("can't be blank")
  end
```
