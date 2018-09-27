require './lib/java'

class Cow
  extend Java

  public static void def main
    cuddles = Cow.new(name: 'Cuddles', weight: 900)
    puts "Cuddles: #{cuddles}"
    eat_result = cuddles.eat(10)
    puts "Eat result: #{eat_result.inspect}"
    puts "Weight: #{cuddles.weight}"
  end

  def initialize(name:, weight:)
    @name = name
    @weight = weight
  end

  attr_reader :name, :weight

  public def to_s
    "Cow { name: #{name}, weight: #{weight}}"
  end

  # public def eat(food_weight)
  public void def eat(food_weight)
    chew(food_weight)
    # Normally this returns the result of the assignment.
    @weight += food_weight
  end

  private void def chew(food_weight)
    puts((['Om'] + (['nom…'] * food_weight)).join(' '))
  end
end

# $ cd ~/workspace/sunrise-ruby/java
# $ pry -r ./demo.rb
# pry> show-source Cow
# pry> Cow.main
