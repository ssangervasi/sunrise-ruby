# Common style: public methods up top, private methods below

## Code example

```ruby
class Horse
  def initialize(name:, height:, length:, weight:, age:, breed:, race_history:)
    # @... initialize attributes
  end

  def nigh
    puts neigh_message
  end

  def racing_profile
    @racing_profile ||= build_racing_profile
  end

  def body_mass_index
    body_mass_index_calculator.result
  end

  private

  def build_racing_profile
    <<~PROFILE
      Name: #{name}
      Age: #{age}
      BMI: #{body_mass_index}
      Races ran: #{race_history.count}
      Races won: #{races_won.count}
    PROFILE
  end

  def races_won
    @races_won ||= race_history.select { |race| race.winner == name }
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

  def neigh_message
    <<~NEIGH
      Neigh!!!!
      I'm a horse named #{name}!
      Neighh, I say unto you!
    NEIGH
  end

  def this_is_secretly_unused
    53.times { neigh }
  end
end

```

## Pros

* Easy to find public methods
* Less "noise" because `private` only appears once
* Easy to elevate a method to the public section with a single copy/paste

## Cons

* Creates distance between public interface and implementation (e.g. `#build_racing_profile`)
* For long classes it's possible to lose track of which section a method is in.
* Raises debates over whether there should be additional indentation.

## Lesser known facts

* Using `private` is still a method call, not a syntax keyword.
* The method is part of the Module module.
* Calling with no arguments sets a flag on the class.
* The method returns `self`, i.e. the class object. (Does not return the method name!)



