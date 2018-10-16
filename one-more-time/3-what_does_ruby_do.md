# Ok, what does ruby do?

## `Time.new`

* Takes bunch of numbers in descending order of magnitude.
* Uses the system time zone, i.e. local time

## `Time.utc`

* Same signature as `Time.new`
* Uses UTC

## `Time.parse`

* Not part of the core Time class - needs to `require 'time'`
* Uses timezone offset if present, e.g. `-7:00` or `Z`
* **Uses systme time zone if offset is absent**

## `DateTime.parse`

* DateTime must be loaded using `require 'date'`
* Same time zone offset behavior.
* Does not compare equal to Time even when the result of `#to_time` does.
