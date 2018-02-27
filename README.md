# sequel_impala

sequel_impala adds support for Sequel to connect to the Impala database
via the included impala driver, and the included jdbc-hive2 driver under JRuby.

# Source Code

Source code is available on GitHub at https://github.com/outcomesinsights/sequel_impala

# Usage

After installation, Sequel will automatically pick up the adapter as long as
the lib directory is in RUBYLIB, if you use a connection string starting with
`impala`, or `jdbc:hive2` on JRuby.

# Connection Strings

If using the impala driver (default host is localhost, default port is 21000):

    impala://host:port

If using the jdbc:hive2 driver on JRuby (port 21050 works in testing):

    jdbc:hive2://host:port/;auth=noSasl

# Dependencies

* sequel 4+
* thrift gem

# License

MIT/Apache

# Author

Ryan Duryea <aguynamedryan@gmail.com>

Work on sequel_impala is generously funded by [Outcomes Insights, Inc.](http://outins.com)

# Previous Author

Jeremy Evans <code@jeremyevans.net>

Provided initial work on this gem, and continues to maintain [Sequel](http://sequel.jeremyevans.net/).  We can't thank you enough!
