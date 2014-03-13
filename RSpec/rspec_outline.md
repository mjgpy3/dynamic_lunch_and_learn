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
```
describe '.some_class_method'
```

Use `#` when talking about instance methods, e.g.
```
describe '#some_instance_method'
```
### Class conventions
Use the qualified name of a class, e.g.
```
describe Foo::Bar::MyClass
```
The `ExampleGroup` (and its children) can access the
qualified class with `described_class`

## `context`
### What is it
It is just an alias of `describe`

### General conventions
Begin context with `'when'` or `'with'` and describe _state_, e.g.
```
context 'when a valid request is made'
```
### Rule of thumb
If an `it` describes more than the action to be asserted, refactor, e.g.
```
  it 'returns 404 if the car is not found'
```
becomes
```
  context 'when the car is not found' do
    it 'returns 404'
  end
```

 - `let`
  - What and benefit (vs. instance variables)
 - Factories
  - Why the community favors them over fixtures
  - FactoryGirl
   - Example
 - Test doubles
  - Mocks vs. stubs (maybe fakes and dummy too?)
  - When to mock
   - Example
  - When to stub
   - Example
 - `guard`
  - Why?
 - `should` vs. `expect`
  - Why `expect` is preferred
