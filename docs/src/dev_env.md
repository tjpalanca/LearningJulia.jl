# Development Environment 

* I am coming from RStudio so I am very, very spoiled. 
* I like VS Code so I decided to set up a cloud-based VS code instance using 
  the `cdr/code-server` docker image and layer R, Python, and Julia onto the 
  image. I am using Julia 1.6 as it mainly solves a lot of Time to First 
  Plot problems which I suspect will cause me issues. 
* After watching some of the JuliaCon videos on YouTube, I was able to set up
  the Julia extension with inline results and some cool stuff like workspaces
  and environments. 
* It feels like RStudio! Although, the Language Server can 
  sometimes choke up for no apparent reason, and it takes a while for 
  autocomplete to kick in after loading a package using `using`.