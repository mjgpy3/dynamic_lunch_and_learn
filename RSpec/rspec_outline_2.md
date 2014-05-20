# Test Doubles

_double_ is the broad category of objects that stand-in for real data in test

Acc. to Martin Fowler in "Mocks Aren't Stubs"
 - **Dummy**, objects are passed around but never actually used. Usually they are just used to fill parameter lists.
  - `anything` is what I use in RSpec as a "double"
 - **Fake**, objects actually have working implementations, but usually take some shortcut which makes them not suitable for production (an in memory database is a good example).
  - e.g. duck-typing
 - **Stubs**, provide canned answers to calls made during the test, usually not responding at all to anything outside what's programmed in for the test. Stubs may also record information about calls, such as an email gateway stub that remembers the messages it 'sent', or maybe only how many messages it 'sent'.
 - **Mocks**, [...] objects pre-programmed with expectations which form a specification of the calls they are expected to receive.

## Stubs
By above, stub when you require certain functionality that the SUT needs to force the condition to be tested, e.g.
```ruby
describe Warrior do

  context 'when there are no swords in the arsenal' do

    let(:sword_arsenal) { SwordArsenal.new }

    before(:each) do
      allow(sword_arsenal).to receive(:all_swords).and_return([])
    end

    context 'and the warrior gets their weapon from the arsenal' do

      before(:each) do
        subject.gets_weapon_from(sword_arsenal)
      end

      it 'will use tae kwon do as a primary weapon' do
        expect(subject.primary_weapon).to equal(:tae_kwon_do)
      end

    end

  end

end
```

## Mocks
By above, use mocks to verify that a method was called, e.g.
```ruby
describe Patron do

  # ...

  context 'when the patron is happy' do

    before(:each) do
      subject.happiness = :high
    end

    it 'gives a tip upon leaving' do
      expect(waiter).to receive(:give_tip).with(anything)
      subject.leave_bar
    end

  end

end
```

# When to Mock

*WARNING:* the following is heavily my opinion, please fight it as you see fit!

## Mocking within the class/entity under test
Generally a code smell, indicating, either:
 1. Too many responsibilities in class
 2. Method is too complex
 3. Method references too many, or too complex dependencies

## Mocking dependencies

