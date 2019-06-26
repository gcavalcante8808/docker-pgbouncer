Docker-PGBouncer
----------------

This is an alpine with PGBouncer installed and a bash entrypoint script that write
pgbouncer.ini and userlist.txt(auth plain) files.

Usage
-----

You need to provide the following envinronment variables:

 * DB_HOST: address of the target postgres database server;
 * DB_NAME: name of the target database;
 * DB_USER: user with privileges in the given database;
 * DB_PASSWORD: password of the user.

The following env vars are optional but often used:

 * CONNECTION_OPTIONS: Default options for connection, separated by whitespace.
 * IGNORE_STARTUP_OPTIONS: Options to be ignored, separated by whitespace.. See http://manpages.ubuntu.com/manpages/trusty/man5/pgbouncer.5.html.

**WARNING**: Invalid connection options will make the pgbouncer to ignore the database entirelly. 

The pgbouncer is configured to operate in session and a have an envinronment variabled called `MAX_CLIENT_CONN`, with
the default value 100; define the variable to change the value in pgbouncer.ini.

You can see an full docker-compose example [[Here](https://github.com/gcavalcante8808/docker-pgbouncer/blob/master/docker-compose.yml)].

The container listens on 5432 by default and use the same name of the `DB_NAME` env variable for the database.

Author
------

Author: Gabriel Abdalla Cavalcante Silva (gabriel.cavalcante88@gmail.com)

