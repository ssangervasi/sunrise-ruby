# Fine, what does Rails do?

* TimeWithZone core extension makes the entire application run in UTC by default.
* **Does not hack `Time.new`** so you will still get system time from this method!

## Example application

* ReminderFinder
