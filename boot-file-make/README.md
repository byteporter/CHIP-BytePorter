System V init script template
=============================

M4 Template
-----------

I forked this project so I could change the shell script to an `m4` template
setup using a Makefile. This allows me to change the base shell script if
necessary and easily update all the init scripts I've created using it. To
do this, the variables from the shell script will need to be defined in
an `m4` macro file which will be combined with the `template.m4` file
to generate the output.

### Script name and building

Your script name will be determined by your invocation of `make`. For example,
to create a script for a service called `test.sh`, you would create a config
file named `test.config.m4`. To run the macro and generate the init script,
call `make test`.

### Script configuration

Use the `define` macro from `m4` to define your configuration variables. 
Because `m4` will be called with the `-P` flag, define in the config file is
prefixed making the macro `m4_define`.

The configuration maps to the init script as follows:

```
__LSB_INIT_INFO => entire LSB info block contents
__WORKINGDIR => dir
__CMD => cmd
__CMDUSER => user
```

An example configuration comes with this code in the file `template.config.m4`.

Explanation of init shell script
--------------------------------

A simple template for init scripts that provide the start, stop,
restart and status commands.

Handy for [Node.js](http://nodejs.org) apps and everything
else that runs itself.

Getting started
---------------

Copy _template_ to /etc/init.d and rename it to something
meaningful. Then edit the script and enter that name after _Provides:_
(between _### BEGIN INIT INFO_ and _### END INIT INFO_).

Now set the following three variables in the script:

### dir ###

The working directory of your process.

### cmd ###

The command line to start the process.

### user ###

The user that should execute the command (optional).
If not set, the command will be called as root (via `sudo ...`).

Here's an example for an app called
[algorithms](http://algorithms.ubercode.de):

    dir="/var/apps/algorithms"
    cmd="node server.js"
    user="node"

Script usage
------------

### Start ###

Starts the app.

    /etc/init.d/algorithms start

### Stop ###

Stops the app.

    /etc/init.d/algorithms stop

### Restart ###

Restarts the app.

    /etc/init.d/algorithms restart

### Status ###

Tells you whether the app is running. Exits with _0_ if it is and _1_
otherwise.

    /etc/init.d/algorithms status

Logging
-------

By default, standard output goes to _/var/log/scriptname.log_ and
error output to _/var/log/scriptname.err_. If you're not happy with
that, change the variables `stdout_log` and `stderr_log`.

License
-------

Copyright (C) 2012-2014 Felix H. Dahlke

This is open source software, licensed under the MIT License. See the
file LICENSE for details.
