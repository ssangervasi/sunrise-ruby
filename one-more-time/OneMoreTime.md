
# Joaks

https://xkcd.com/2050/

# Code Samples

```
```


```ruby


tod_ten =  Tod::TimeOfDay.parse('10:00:00')
# => #<Tod::TimeOfDay:0x007f407dcb3c88 @hour=10, @minute=0, @second=0, @second_of_day=36000>
tod_sixteen =  Tod::TimeOfDay.parse('16:00:00')
# => #<Tod::TimeOfDay:0x007f407e2b0230 @hour=16, @minute=0, @second=0, @second_of_day=57600>
ap WeeklyEvent.where(start_time: tod_ten..tod_sixteen, day_of_week: 0...2)

WeeklyEvent.create!(
  start_time: (nyc_now - 1.hour),
  end_time: (nyc_now + 1.hour),
  day_of_week: nyc_now.wday,
)

def event_query_borked(time_in_region)
  day_of_week = time_in_region.wday
  time_of_day = Tod::TimeOfDay(time_in_region)
  WeeklyEvent.where(
    day_of_week: day_of_week
  ).where(
    ':time_of_day BETWEEN start_time AND end_time',
    time_of_day: time_of_day #.to_s
  )
end

tod_ten =  Tod::TimeOfDay.parse('10:00:00')
tod_sixteen =  Tod::TimeOfDay.parse('16:00:00')
tod_twenty =  Tod::TimeOfDay.parse('20:00:00')
ap WeeklyEvent.where(start_time: tod_sixteen..tod_twenty)

#

now = Time.zone.now
utc_now = now.utc
nyc_now = now.in_time_zone('America/New_York')


nyc_tod = Tod::TimeOfDay(nyc_now)
# Passing in a TimeWithZone causes the time of day to be converted to UTC!
# nyc_event = WeeklyEvent.create!(
#   start_time: nyc_now,
#   end_time: (nyc_now + 30.minutes),
#   day_of_week: nyc_now.wday,
# )
nyc_event = WeeklyEvent.create!(
  start_time: nyc_tod,
  end_time: (nyc_tod + 30.minutes),
  day_of_week: nyc_now.wday,
)

utc_tod = Tod::TimeOfDay(utc_now)
utc_event = WeeklyEvent.create!(
  start_time: utc_now,
  end_time: (utc_now + 30.minutes),
  day_of_week: utc_now.wday,
)

puts "NYC: TOD = #{nyc_tod}; event.start_time = #{nyc_event.start_time}"
puts "UTC: TOD = #{utc_tod}; event.start_time = #{utc_event.start_time}"


WeeklyEvent.new(
  day_of_week: now.wday,
  start_time: (now - 1.hour),
  end_time: (now + 1.hour),
)

```

```ruby
#
Rails.configuration.active_record.time_zone_aware_types = %i[datetime]
```
