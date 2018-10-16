# What does my computer do?


```
$ man date

The following environment variables affect the execution of date:

TZ      The timezone to use when displaying dates.  The normal format is a pathname relative to /usr/share/zoneinfo.  For
        example, the command ``TZ=America/Los_Angeles date'' displays the current time in California.  See environ(7) for
        more information.

$ date
Tue Oct 16 09:19:32 PDT 2018

$ TZ=America/New_York date
Tue Oct 16 12:19:33 EDT 2018
```

# What does Ruby do?

[When to use DateTime](https://ruby-doc.org/stdlib-2.5.1/libdoc/date/rdoc/DateTime.html#class-DateTime-label-When+should+you+use+DateTime+and+when+should+you+use+Time-3F)

> So when should you use DateTime in Ruby and when should you use Time? Almost certainly you'll want to use Time since your app is probably dealing with current dates and times. However, if you need to deal with dates and times in a historical context you'll want to use DateTime to avoid making the same mistakes as UNESCO.
> **If you also have to deal with timezones then best of luck** - just bear in mind that you'll probably be dealing with local solar times, since it wasn't until the 19th century that the introduction of the railways necessitated the need for Standard Time and eventually timezones.


# What does Rails do?

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
