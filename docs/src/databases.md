# Databases

Source: `scripts/Database.jl`
Using: `LibPQ.jl`, `Octo.jl`, `Stipple.jl`

* My favorite database is PostgreSQL, so I decided to see how I can access
  this database.
* There's a standard interface for connecting to databases, but 
  sadly that doesn't seem to be available for Postgres, instead I'm redirected
  to the `libpq` interface `LibPQ.jl`

## LibPQ.jl

* Is there something more high level that I can use? 

### Reading

* With this, I'm able to to make queries and execute them, it's quite low level
  but it works for my standard Postgres installation.
* I'm able to transpose this into a `DataFrame`. I don't quite understand
  the many different tabular structures yet (I'm used to the built-in dataframe 
  in R), but I can see how that works. See [Data Frames](@ref).

### Writing 

* DDL Statements have to be written manually
* Transactions have to be written manually (but easily wrapped)
* Yes I can insert stuff, but still need SQL knowledge

## ODBC.jl 

* This is a more standard interface, but it's less feature rich. I'm skipping 
  this for now but this might be the way to get to lesser known DBs.

## Octo.jl 

* It's a SQL Query DSL in Julia. Amazing, is this going to be like the 
  `{dbplyr}` package in R? Making a decent data access layer is soooooo hard!
* Okay so now I have to actually use structs
* It supports Postgres, and MySQL and SQLite too!
* Okay I was able to query the information schema using a basic query tool. 
  I'm really not sure why I have to define a struct
* Really these function documentations are a little over my head: for example:
  `Schema.model(` will surface `CoreType where T` or something which does not
  really give me information about what arguments to place). May just be 
  that we need to add more docstrings or something?
* SQL keywords in the DSL part need to be capitalized
* I was able to query a bit and get in tune with the DSL, seems ok as a web
  app backend ORM but not for data analysis.

## Query.jl 

> The package currently provides working implementations for in-memory data
> sources, but will eventually be able to translate queries into e.g. SQL. There
> is a prototype implementation of such a "query provider" for SQLite in the
> package, but it is experimental at this point and only works for a very small
> subset of queries.

This one is super promising but isn't implemented yet.
