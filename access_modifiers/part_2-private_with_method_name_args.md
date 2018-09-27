# Older(?) style: call private with method names

## Code example

```ruby
class Horse
  def initialize(name:, height:, length:, weight:, age:, breed:, race_history:)
    # @... initialize attributes
  end

  def nigh
    puts neigh_message
  end

  def neigh_message
    <<~NEIGH
      Neigh!!!!
      I'm a horse named #{name}!
      Neighh, I say unto you!
    NEIGH
  end
  private :neigh_message

  def racing_profile
    @racing_profile ||= build_racing_profile
  end

  def build_racing_profile
    <<~PROFILE
      Name: #{name}
      Age: #{age}
      BMI: #{body_mass_index}
      Races ran: #{race_history.count}
      Races won: #{races_won.count}
    PROFILE
  end
  private :build_racing_profile

  def races_won
    @races_won ||= race_history.select { |race| race.winner == name }
  end
  private :races_won

  def body_mass_index
    body_mass_index_calculator.result
  end

  def body_mass_index_calculator
    @body_mass_index_calculator ||=
      HorseBodyMassIndexCalculator.new(
        breed: breed,
        height: height,
        length: length,
        weight: weight,
      )
  end
  private :body_mass_index_calculator

  def this_method_has_a_really_long_name(and_takes:, a_lot: 99, of_arguments: {})
    53.times { neigh }
  end
  private :this_method_has_a_really_long_name

  ##
  # Alternate version
  ##
  private :neigh_message,
          :build_racing_profile,
          :body_mass_index_calculator,
          :races_won,
          :this_is_secretly_unused
end

```

## Pros

* Easy to see whether a method is private.
* Allows private helpers to be defined next to the public methods they support.
* Elevating a method to public requires 1-line diff.

## Cons

* Public methods get burried. (E.g. `#body_mass_index`)
* Changing a method name requires changing this weird symbol thing. (Error prone)
* About as noisy as a baby taking care of another baby.


## Lesser known facts

* It's possible to do the alternate version which resembles `attr_reader`.
* Alternate version only works if you put it at the *bottom*
* You can pass strings if you're a big fan of quotes.

