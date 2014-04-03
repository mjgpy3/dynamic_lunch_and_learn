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
### `expect` is newer and preferred 
 - `should` is defined on `Kernel` not `BasicObject` so if an object 
   inherits from `BasicObject` `should` will not exist on it
 - `expect` is more readable when testing blocks, e.g.
```ruby
lambda { do_something }.should raise_error(AnError)
# vs.
expect { do_something }.to raise_error(AnError)
```
 - `should` has some unexpected behavior, e.g., in Ruby <= 1.8,
```ruby
# This spec passes
describe Integer do
  it "sucks" do
    10.should == 10
    10.should != 10 # => !(10.should.==(10))
  end
end
```

## Factories
 - Provide a DSL for specifying test data (from specific classes)
 - More work up front, easing future maintenance (centralized definition of test data)

### FactoryGirl Features
#### Traits
Name a group of attributes on an entity, e.g.
```ruby
FactoryGirl.define do
  factory :tv_show

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
FactoryGirl makes stubbing an entire object easy, e.g.
```ruby
the_black_knight = FactoryGirl.build_stubbed(:monty_python_character)
```

#### Hooks
FactoryGirl provides four hooks, e.g.
```ruby
after(:build)   # After FactoryGirl.build
before(:create) # Before FactoryGirl.create
after(:create)  # After FactoryGirl.create
after(:stub)    # After FactoryGirl.build_stubbed

# Usage might look like...

factory :user do
  after(:build) { |user| generate_hashed_password(user) }
end
```

## Controller Conventions
See [the docs](https://www.relishapp.com/rspec/rspec-rails/docs/controller-specs) for some of the helpful tools for testing controllers that RSpec provides
See [rspec-style-guide](https://github.com/howaboutwe/rspec-style-guide#controllers) for best practices

## Test Doubles

_double_ is the broad category of objects that stand-in for real data in test

Acc. to Martin Fowler in "Mocks Aren't Stubs"
 - **Dummy**, objects are passed around but never actually used. Usually they are just used to fill parameter lists.
 - **Fake**, objects actually have working implementations, but usually take some shortcut which makes them not suitable for production (an in memory database is a good example).
 - **Stubs**, provide canned answers to calls made during the test, usually not responding at all to anything outside what's programmed in for the test. Stubs may also record information about calls, such as an email gateway stub that remembers the messages it 'sent', or maybe only how many messages it 'sent'.
 - **Mocks**, [...] objects pre-programmed with expectations which form a specification of the calls they are expected to receive.

### Stubs
By above, stub when you require certain functionality that the SUT needs to force the condition to be tested, e.g.
```ruby
describe Warrior do

  context 'when there are no swords in the arsenal' do

    let(:sword_arsenal) { SwordArsenal.new }

    before(:each) do
      allow(sword_arsenal).to receive(:all_swords) { [] }
      subject.gets_weapon_from(sword_arsenal)
    end

    it 'will use tae kwon do as a primary weapon' do
      expect(subject.primary_weapon).to equal(:tae_kwon_do)
    end

  end

end
```

### Mocks
By above, use mocks to verify that a method was called, e.g.
```ruby
describe Patron do
  
  context 'when the patron is happy' do

    before(:each) do
      subject.happiness = :high
    end

    it 'gives a tip upon leaving' do
      bartender = double("Bartender")

      expect(bartender).to receive(:give_tip).with(anything())
      subject.leave_bar
    end

  end

end
```

# Resources
 - [RSpec best practices](http://betterspecs.org/)
 - [FactoryGirl](https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md)
 - [Controller testing](https://www.relishapp.com/rspec/rspec-rails/docs/controller-specs)
 - [Rails specific best practices](https://github.com/howaboutwe/rspec-style-guide)
