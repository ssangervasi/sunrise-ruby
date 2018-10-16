# frozen_string_literal: true

puts '~ Constructing ~'

time_parts_arr = [
  2018, # Year
  10,   # Month
  16,   # Day
  17,   # Hour
  18,   # Minute
  19.5  # Second
]

time_from_new = Time.new(*time_parts_arr)
puts 'time_from_new:', time_from_new

time_from_utc = Time.utc(*time_parts_arr)
puts 'time_from_utc:', time_from_utc
puts 'Equal?', (time_from_utc == time_from_new)
puts 'Difference (float):', time_from_new - time_from_utc

puts
puts '~ Parsing ~'

utc_iso8601 = '2018-10-16T17:18:19.5Z'

begin
  puts 'utc_time_from_parse'
  utc_time_from_parse = Time.parse(utc_iso8601)
  puts utc_time_from_parse
rescue NoMethodError
  puts 'JK - there is no Time.parse by default'
end

puts
require 'time'

utc_time_from_parse = Time.parse(utc_iso8601)
puts 'utc_time_from_parse', utc_time_from_parse

system_iso8601 = '2018-10-16T17:18:19.5'
system_time_from_parse = Time.parse(system_iso8601)
puts 'system_time_from_parse', system_time_from_parse

puts
require 'date'

datetime_from_parse = DateTime.parse(utc_iso8601)
puts 'datetime_from_parse', datetime_from_parse

puts 'DateTime equals local?', datetime_from_parse == time_from_new
puts 'DateTime equals UTC?', datetime_from_parse == time_from_utc
puts 'DateTime#to_time equals UTC time?', datetime_from_parse.to_time == time_from_utc

puts
puts 'Time#iso8601', utc_time_from_parse.iso8601, system_time_from_parse.iso8601
puts 'DateTime#iso8601', datetime_from_parse.iso8601
