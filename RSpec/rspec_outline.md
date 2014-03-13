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
The `ExampleGroup` (and it's children) can access the
qualified class with `described_class`

 - `describe`
  - Should talk about some programming entity
 - `context`
  - What (it is) and when (it should be used)
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
