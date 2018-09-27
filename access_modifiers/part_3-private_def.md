# Ruby 2.3 accidental feature: private def

## Code example

```ruby
class Horse
  def initialize(name:, height:, length:, weight:, age:, breed:, race_history:)
    # @... initialize attributes
  end

  def nigh
    puts neigh_message
  end

  private def neigh_message
    <<~NEIGH
      Neigh!!!!
      I'm a horse named #{name}!
      Neighh, I say unto you!
    NEIGH
  end

  def racing_profile
    @racing_profile ||= build_racing_profile
  end

  private def build_racing_profile
    <<~PROFILE
      Name: #{name}
      Age: #{age}
      BMI: #{body_mass_index}
      Races ran: #{race_history.count}
      Races won: #{races_won.count}
    PROFILE
  end

  private def races_won
    @races_won ||= race_history.select { |race| race.winner == name }
  end

  def body_mass_index
    body_mass_index_calculator.result
  end

  private def body_mass_index_calculator
    @body_mass_index_calculator ||=
      HorseBodyMassIndexCalculator.new(
        breed: breed,
        height: height,
        length: length,
        weight: weight,
      )
  end

  private def this_method_has_a_really_long_name(and_takes:, a_lot: 99, of_arguments: {})
    53.times { neigh }
  end
end

```

## Pros

* Easy to see whether a method is private.
* Allows private helpers to be defined next to the public methods they support.
* Less noisy than passing a copy of the method name.
* Renaming a method only requires one change.
* Elevating a method to public requires 1-line diff.
* Looks like Java


## Cons

* Public methods get burried. (E.g. `#body_mass_index`)
* Debetable noise level.
* Method names stick out extra far.
* Looks like Java.


## Lesser known facts

* It's possible to do the alternate version which resembles `attr_reader`.
* Alternate version only works if you put it at the *bottom*
* You can pass strings if you're a big fan of quotes.

