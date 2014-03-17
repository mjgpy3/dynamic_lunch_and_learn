RSpec Outline
-----------

# 2 Questions
 - How much do you know about RSpec?
 - What do you hate about testing?

# What It Tries To accomplish
 - BDD-esque framework (emphasis on "framework")
  - Descriptive (tries to tell a story)
 - Iterative development (baby steps)

# Best Practices
## `describe`
### Method conventions

Use `.` or `::` when talking about class methods, e.g.
```ruby
describe '.some_class_method'
```

Use `#` when talking about instance methods, e.g.
```ruby
describe '#some_instance_method'
```
### Class conventions
Use the qualified name of a class, e.g.
```ruby
describe Foo::Bar::MyClass
```
The `ExampleGroup` (and its children) can access the
qualified class with `described_class` or an instance
of the class with `subject`

## `context`
### What is it
It is just an alias of `describe`

### General conventions
Begin context with `'when'` or `'with'` and describe _state_, e.g.
```ruby
context 'when a valid request is made'
```
### Rule of thumb
If an `it` describes more than the action and expectation, refactor, e.g.
```ruby
  it 'returns 404 if the car is not found'
```
becomes
```ruby
  context 'when the car is not found' do
    it 'returns 404'
  end
```

## `let`
### Prefer to instance variables
 - `let` uses lazily loaded methods, caching values after first call
  - `NameError` if mistype (what you might expect on a mistype)
  - Instance variables return `nil` (false positives/negatives, unexpected errors)

## `should` vs. `expect`


## Factories
 - Provide a DSL for specifying test data (from specific classes)
 - More work up front, easing future maintenance (centralized definition of test data)

### FactoryGirl Features
#### Traits
Name a group of attributes on an entity, e.g.
```ruby
FactoryGirl.define do
  factory :tv_show

    # TODO: Use better, add SP
    
    trait :live_action do
      name "Breaking Bad"
      certificate :tv_14
    end

    trait :cartoon do
      name "Adventure Time"
      certificate :tv_pg
    end

  end
end

# Create instance
create(:show, :live_action)
```
 - Traits can be used within traits to mix-in
 - _See FactoryGirl's readme for more ways of specifying traits_

#### Lazy Attributes
Use a block instead of static data, e.g.
```ruby
# ...
location { Locations.get_current }
```

#### Sequences
Provide incrementing numbers for attributes, e.g.
```ruby
FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@foo.bar"
  end
end

FactoryGirl.generate :email
# => user1@foo.bar

FactoryGirl.generate :email
# => user2@foo.bar
```

#### `skip_create`
Tells FactoryGirl not to try to save the entity once created, e.g.
```ruby
factory :user_outside_database do
  skip_create
end
```


#### Stubbed Objects
Factory girl makes stubbing an entire object easy, e.g.
```ruby
the_black_knight = FactoryGirl.build_stubbed(:monty_python_character)
```

## Test Doubles
Acc. to Martin Fowler in "Mocks Aren't Stubs"
 - **Dummy**, objects are passed around but never actually used. Usually they are just used to fill parameter lists.
 - **Fake**, objects actually have working implementations, but usually take some shortcut which makes them not suitable for production (an in memory database is a good example).
 - **Stubs**, provide canned answers to calls made during the test, usually not responding at all to anything outside what's programmed in for the test. Stubs may also record information about calls, such as an email gateway stub that remembers the messages it 'sent', or maybe only how many messages it 'sent'.
 - **Mocks**, [...] objects pre-programmed with expectations which form a specification of the calls they are expected to receive.


 - `should` vs. `expect`
  - Why `expect` is preferred
