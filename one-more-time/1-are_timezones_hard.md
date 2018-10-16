# Is time hard?

Yes.

[Your Calindrical Fallacy](http://yourcalendricalfallacyis.com/#timezones-always-are-on-the-hour-mark)
is a great resource for reminding yourself what's hard about it.

# But the computer handles it for me, right?

The Ruby documentation for [When to use DateTime](https://ruby-doc.org/stdlib-2.5.1/libdoc/date/rdoc/DateTime.html#class-DateTime-label-When+should+you+use+DateTime+and+when+should+you+use+Time-3F)
is very descriptive. I have read it serveral times and I still can't remember
why it matters.

But even Ruby wants to warn you of danger:

> So when should you use DateTime in Ruby and when should you use Time? Almost certainly you'll want to use Time since your app is probably dealing with current dates and times. However, if you need to deal with dates and times in a historical context you'll want to use DateTime to avoid making the same mistakes as UNESCO.
> **If you also have to deal with timezones then best of luck** - just bear in mind that you'll probably be dealing with local solar times, since it wasn't until the 19th century that the introduction of the railways necessitated the need for Standard Time and eventually timezones.

# Oh boy.

Yep.

And, as always, there's a relevant XKCD:

![xkcd time](https://imgs.xkcd.com/comics/6_6_time.png).
