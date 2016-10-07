tips:

--------


#### 删除

```
class Building < ActiveRecord::Base
  has_many :apartments, dependent: :destroy
end

class Apartment < ActiveRecord::Base
  has_many :rooms, dependent: :destroy
end

## rails4.0以后可以使用 数据库自带的方法来删除

class CreateForeignKeys < ActiveRecord::Migration
  def change
    add_foreign_key :apartments, :buildings, on_delete: :cascade
    add_foreign_key :rooms, :apartments, on_delete: :cascade
    add_foreign_key :furnitures, :rooms, on_delete: :cascade
    add_foreign_key :materials, :furnitures, on_delete: :cascade
  end
end

```


#### cable

 --skip-action-cable
 
#### comment

```
def is_prime?(n)
  # Any factor greater than sqrt(n) has a corresponding factor less than 
  # sqrt(n), so once i >=sqrt(n) we have covered all cases
  while i * i < n
    if n % i == 0 
      return false
    end
    i += 1
  end
  true
end
```

#### Struct


```
Struct.new("Person", :height, :hair_color, :dominant_hand, :iq, :astigmatic?)
# Or,

Person = Struct.new(:height, :hair_color, :dominant_hand, :iq, :astigmatic?)

sally = Person.new(165, "red", :left, 180, true)
```

#### sidekiq

```
# https://blog.codeship.com/improving-rails-performance-better-background-jobs/

# https://devcenter.heroku.com/articles/ruby-memory-use


class ContentSuggestionWorker
  include Sidekiq::Worker

  def perform
    User.where(subscribed: true).find_in_batches(batch_size: 100) do |group|
      group.each { |user| ContentMailer.suggest_to(user).deliver_now }
    end
  end
end

find_in_batches

# 拆分: 在指量的任务中不取出也不真正的进行操作

class ContentSuggestionEnqueuer
  def self.enqueue
    User.where(subscribed: true).pluck(:id).each do |user_id|
      ContentSuggestionWorker.perform_async(user_id)
    end
  end
end
class ContentSuggestionWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(user_id)
    user = User.find(user_id)
    ContentMailer.suggest_to(user).deliver_now
  end
end


# GC ,这个我们自己试好像没有用?
class ContentSuggestionWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(user_id)
    user = User.find(user_id)
    ContentMailer.suggest_to(user).deliver_now
    GC.start
  end
end

# https://github.com/bear-metal/tunemygc gc第三方服务
```

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
