# Using LibPQ for database connections

using LibPQ, Tables
using DataFrames

conn = LibPQ.Connection(ENV["POSTGRESQL_URL"])

result = execute(conn, "select * from information_schema.tables")
data = columntable(result)
DataFrame(result)

execute(conn, "select * from clients") |>
    DataFrame

close(conn)

# Searching for a higher level package 
# Octo.jl

using Octo.Adapters.SQL
using Octo.Adapters.PostgreSQL

Repo.debug_sql()

Repo.connect(
    adapter  = Octo.Adapters.PostgreSQL,
    dbname   = ENV["POSTGRESQL_DATABASE"],
    user     = ENV["POSTGRESQL_USERNAME"],
    password = ENV["POSTGRESQL_PASSWORD"],
    host     = ENV["POSTGRESQL_ADDRESS"]
)
struct Table
end

Schema.model(Table, table_name="information_schema.tables", primary_key=nothing)
tables = from(Table)


Repo.query(tables)
Repo.query([SELECT * FROM tables])
Repo.query([SELECT * FROM tables WHERE tables.table_name == "trips"])