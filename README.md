# auto-sendmail

Some totalitarian regimes require their pupils to send an E-Mail to every teacher.  
This script automates that ;)

# Usage

Simply run sender.sh as a cronjob

The programm loops over every file in `./tasks/taskname/` and sends the specified emails.

A Randomisation factor of up to 20 minutes in the past is applied to the Send-Date

# Filename Format
`<WEEKDAY>_<HOUR>_<MINUTE>_<DESCRIPTION>`

| Var         | Description |
| ----------- | ----------- |
| WEEKDAY     | Number of Weekday (0..6) 0 is Sunday (See date: %w) |
| HOUR        | HOUR in 24h format (00..23) (See date: %H) |
| MINUTE      | Minute of hour (00..59) (See date: %M) |
| DESCRIPTION | Anything you want.. Not used by programm |
