require 'concurrent'
require 'benchmark/ips'


class Sleepy
  include Concurrent::Async

  def initialize(name)
    @name = name
  end

  def fetch(delay = 1)
    puts "Sleepy #{@name}"
    sleep(delay)
    puts "Wakey #{@name}"
    {
      name: @name,
      thread_id: Thread.current.object_id
    }
  end
end

def sync_pets
  puppy = Sleepy.new('puppy')
  kitten = Sleepy.new('kitten')

  pup_response = puppy.fetch
  kit_response = kitten.fetch

  [
    pup_response,
    kit_response
  ]
end

def async_pets
  puppy = Sleepy.new('puppy')
  kitten = Sleepy.new('kitten')

  pup_response = puppy.async.fetch
  kit_response = kitten.async.fetch

  [
    pup_response.value, # Blocks
    kit_response.value  # Blocks
  ]
end

def await_pets
  puppy = Sleepy.new('puppy')
  kitten = Sleepy.new('kitten')

  pup_response = puppy.await.fetch
  kit_response = kitten.await.fetch

  [
    pup_response.value, # Blocks
    kit_response.value  # Blocks
  ]
end

def check_results(results)
  results.tap do
    puppy, kitten = results.map { |pet| pet[:name] }
    raise "#{puppy} was not puppy" if puppy != 'puppy'
    raise "#{kitten} was not kitten" if kitten != 'kitten'
  end
end

puts 'Demo fetch'
puts check_results(sync_pets)
puts check_results(async_pets)
puts check_results(await_pets)

Benchmark.ips do |b|
  b.report('sync_pets')  { check_results(sync_pets) }
  b.report('async_pets') { check_results(async_pets) }
  b.report('await_pets') { check_results(await_pets) }

  b.compare!
end
