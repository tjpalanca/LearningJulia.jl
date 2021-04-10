# Generative Art

* `nb/generative.jl` and `src/generative.jl`

Something that coincideded with my desire to learn Julia was my desire to create
some generative art, so it would be awesome if I could marry the two and really
do some creative coding in Julia.

## Luxor.jl + Javis.jl

### Luxor.jl

* These two pair together for static and animated charts. Seems very well 
  featured and the tutorials are great. I think for generative art this combo
  will serve us best whereas `Compose.jl` is really more about visualization.
  This [tutorial](http://juliagraphics.github.io/Luxor.jl/stable/tutorial/) is
  pretty amazing!
* This seems more amenable to being Julian, i.e. using features such as 
  broadcasting 
* Luxor is great, the tutorial material is pretty gold standard.
* [Shapes](http://juliagraphics.github.io/Luxor.jl/stable/simplegraphics/)
* Wrap more complicated geoms around functions with parameters

### Javis.jl

* Ran into a bit of a hiccup with one of the dependencies on my cloud instance 
  `Gtk.jl` which required a display, so I needed to install `xvfb` to clear that
  precompilation issue, and then add it to the docker entrypoint.
* Doesn't yet fully support `Pluto.jl` but some things can be hacked around.
* We create Luxor.jl functions that construct objects, and then 
  Javis `Objects` essentially are rendered for each frame from 
  closures defined through those Luxor objects.
* Concepts
  * `Object` calls a function that draws something onto the canvas.
    * `Object` consists of `Frames`, a `func` drawing function, and an
      optional `Animation`
  * `Frames` can be defined as a range (`1:100`), same as previous (`:same`) or
    `RFrames` relative to the previous index.
    * Don't define a frame range > than the background.
* Okay after than brouhaha with the display required on cloud servers, this 
  package is growing quite fast on me. I'm still amazed at how fast things
  just render!

## Compose.jl

* Takes inspiration from R's `{grid}`
* `compose(a, b)` returns a new tree rooted at `a` with `b` as child.
* There is a [Forms gallery](https://giovineitalia.github.io/Compose.jl/latest/gallery/forms/#forms_gallery)
  a [Properties gallery](https://giovineitalia.github.io/Compose.jl/latest/gallery/properties/), and 
  a [Transforms gallery](https://giovineitalia.github.io/Compose.jl/latest/gallery/transforms/) that 
  are all pretty featured 
* Seems pretty well featured for SVG Graphics but no direct path to animation.