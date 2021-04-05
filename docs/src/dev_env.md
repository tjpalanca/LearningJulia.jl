# Development Environment 

## VS Code (`code-server`) with Julia Extension

* I am coming from RStudio so I am very, very spoiled. 
* I like VS Code so I decided to set up a cloud-based VS code instance using 
  the `cdr/code-server` docker image and layer R, Python, and Julia onto the 
  image. 
* I am using Julia 1.6 as it mainly solves a lot of Time to First 
  Plot problems which I suspect will cause me issues. 
* After watching some of the JuliaCon videos on YouTube, I was able to set up
  the Julia extension with inline results and some cool stuff like workspaces
  and environments. 
* It feels like RStudio! Although, the Language Server can 
  sometimes choke up for no apparent reason, and it takes a while for 
  autocomplete to kick in after loading a package using `using`.
* Some of the great features are on version control, particularly with the 
  Git Lens extensions. I can see how more software engineering-types will be 
  attracted to the Julia ecosystem compared to R which attracts domain 
  experts going in the opposite direction.
* I'm pretty sure I can find a VS code extension for anything I need; it's an 
  amazingly rich ecosystem!
* Inline results are something else! Much better than a notebook interface and 
  better than also constantly looking at the console.

## OhMyREPL.jl

* That's cool! Packages can modify the REPL to a deep level. 
* `~/.julia/config/startup.jl` is the equivalent of the `.Rprofile` file

## Pluto.jl

* This is an interesting notebook interface that I want to take a look at.
