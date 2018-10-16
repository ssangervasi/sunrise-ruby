# What does my computer do?

User configured "system" time zone

On MacOS: *System Preference > Date & Time > Time Zone*

## From the command line

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

