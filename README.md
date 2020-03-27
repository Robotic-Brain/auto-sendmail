# auto-sendmail

Some totalitarian regimes require their pupils to send an E-Mail to every teacher.  
This script automates that ;)

**DISCLAIMER: This is a 2h hackjob! If it breaks, it's not my fault!**

Why do i post this? I like FOSS!

# Usage

Simply run `sender.sh` as a cronjob

The programm loops over every file in `./tasks/<taskname>/` and sends the specified emails.

A Randomisation factor of up to 20 minutes in the past is applied to the Send-Date

The Send-Date is based on the magic filename [see below](#filename-format)

Emails are sourced shell scripts which should echo the actual SMTP mail on STDOUT


# Environment
`DATE` contains the fudged date of the email
`DEBUG` can be set to 1 to enable more verbose output

The `.stats` directory (sibling of the original script) contains auto-generated metadata to prevent repeatet executions within a 23h timespan

# Filename Format
`<WEEKDAY>_<HOUR>_<MINUTE>_<DESCRIPTION>`

| Var         | Description |
| ----------- | ----------- |
| WEEKDAY     | Number of Weekday (0..6) 0 is Sunday (See date: %w) |
| HOUR        | HOUR in 24h format (00..23) (See date: %H) |
| MINUTE      | Minute of hour (00..59) (See date: %M) |
| DESCRIPTION | Anything you want.. Not used by programm |

*Please note, that those numbers depend on the set locale of the server*

# Example
An example script is available in `src/tasks/example/5_12_35_example.eml`  
An example for complex stuff is in `src/tasks/example/5_12_35_complex.sh`
