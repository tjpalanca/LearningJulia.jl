# Databases

File: `scripts/Database.jl`

* My favorite database is PostgreSQL, so I decided to see how I can access
  this database.
* There's a standard interface for connecting to databases, but 
  sadly that doesn't seem to be available for Postgres, instead I'm redirected
  to the `libpq` interface `LibPQ.jl`

## LibPQ.jl

* With this, I'm able to to make queries and execute them, it's quite low level
  but it works for my standard Postgres installation.
* 
