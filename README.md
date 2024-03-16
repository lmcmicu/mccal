# *mccal*: a simple reminder calendar

The latest stable release of *mccal* is [v0.1.0](https://github.com/lmcmicu/mccal/releases/tag/v0.1.0).

*mccal* is mainly useful for giving you reminders, which
you can snooze (as often as you like) for however many minutes, hours, or
days that you would like. None of the (at the time I wrote this) available
calendars for Linux/UNIX had this kind of snoozing functionality. This
is the main reason I wrote *mccal*.

When an appointment becomes due, the program will pop up a window with the
appointment text, which you can then dismiss or snooze as desired. The
program also allows you to optionally indicate a set of commands it should
run at that time (e.g., emailing someone, ringing a bell, etc.). *mccal* uses
an external program to implement the window popup. Currently the options are
zenity, gxmessage, and cocoadialog (Mac OS).

I originally coded *mccal* in Perl in the early 2000s. I am currently in the
process of porting it to python.

## Requirements

- Perl, Perl::DateTime, Perl::Time::HiRes, Net::OpenSSH, bash, (gxmessage|zenity|cocoadialog)

## Installation

- copy the files `addappointments`, `findappointment`, `remind`, `synccal`,
  `run_findapps.sh`, and `viewcal` to a directory in your executable path
  (e.g., `~/bin/`).

- copy the file `commonfuncs.pm` to your "library" directory. If you are
  copying to a directory not visible to perl, you will have to
  explicitly add:

        BEGIN {
            push @INC, "<your library directory>";
        }

  to the top of the files: `findappointment`, `remind`.

- customise your window manager to run `run_findapps.sh` at startup.


## User interface

### `addappointments`

- writes an appointment entry to the calendar file


        Usage: addappointments [file]
        Entries must look like: [<weekly|biweekly|monthly|yearly> <N>]
                                [remind <N>]
                                [yyyy-mm-dd] HH:mm
                                [<text>[; command1; command2; ...]]

Note that `command1`, `command2`, etc. are commands to execute upon the
appointment coming due (in addition to the popup gxmessage).

### `viewcal`

- displays appointments

        Usage:
        viewcal [-f <calendar file>] [<year>|<month>|<week>|<today>|<tomorrow>|<yesterday>|<yyyy-mm-dd>|<yyyy-mm>|<yyyy>]


### `run_findapps.sh`

- wrapper for `findappointments` (see below). Kills existing processes
  before starting a new one.

- call this in your window manager's initialization script.

### `getmins`

    Usage: getmins NUMBER[m|h|d|w]


- handy extra tool to help in specyfying reminder times. Use like this:

        $ echo "remind `getmins 24h` 2015-07-09 20:00 Office party"|addappointments 


## "Internal" files:

### `commonfuncs.pm`

- common functions used by all files

### `remind`

- reminds the user of an appointment

### `findappointment`

- checks calendar file periodically for due appointments


To contact the author, see: https://www.michaelcuffaro.com
