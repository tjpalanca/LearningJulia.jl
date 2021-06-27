# Geospatial

For one of the trial art projects I needed to get a shapefile of the Philippines,
I figured I would try to record my findings here.

## GADM.jl

* This is a really easy place to extract standard shapefiles.

## GeoInterface.jl 

* This takes inspiration from the `{sf}` R package so I need to study this =>
  Turns out this is an RFC and is not the simple features interface I expected.
* Luxor had to use `Shapefile.jl` but coming at it from that angle I just got
  super confused about how to transform data from one form to another.
