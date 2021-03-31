# Julia Language Features

## General observations

* I love the named slurping and splatting, an improvement of the R syntax
* It looks like math! Very little cognitive load on translating some work.
* However, the whole multiple dispatch thing, when I watch videos looks amazing,
  but when I try to implement makes my brain hurt. I suffer from the curse
  of seeing OOP in Python and R6 in R. S3 is quite similar but is so much 
  simpler because it's single dispatch.
* Symbols and strings are separate - amaze! Metaprogramming has been something 
  that is quite easy in R and I suspect quite easy in Julia too with the macros.
* Do-block syntax - interesting, the function is first and then the iterable in 
  Julia's `map()` as opposed to R's `purrr::map()`.

## Functions 

* Function composition and piping!
  * Composition operator (`\circ`) can combine two functions together
  * Piping is using the pipe (`|>`) operator 
* Dot syntax for vectorizing is very interesting.  
  * Vectorizing is not required for performance, but they're still prettier
  * Any julia function can be applied by adding a `.` after like `.sin(V)`, or
    before the operator in the case of binary operators like `.+`
    * Amazing yet again!
    * This is just syntactic sugar for the `broadcast` function modifier
    * Nested brodcasts are joined together in a syntactic loop.
    * You can pre-allocate using the dotted assignment `.=`
    * To avoid having too many dots then you can use the `@.` macro to add 
      dots to every singe funciton call in that line.
* Anonymous functions use arrow like in JS: `(x) -> x + 2`
## Control Flow

### Expressions 

* Expressions using `begin` and `end` - no brackets so need this, you can also 
  separate into lines and use parens `(x = 1; y = 2; x + y)`

### Conditionals 

* `if`, `elseif`, `else`, `end` - nothing else to add simple enough
  * If blocks do not have their own variable scope (same as R)
  * They can also return a value like in R
  * They must return a boolean
* Ternary operator can be used `condition ? iftrue: iffalse`
* `&&` and `||` short circuit the expression like in R, so you can use it 
  to define some backup values or substitute the ternary operator
* `&` and `|` evaluate both arguments

```julia
function fact(n::Int)
  n >= 0 || error("n must be non-negative")
  n == 0 && return 1
  n * fact(n-1)
end
```
### Iteration

* `while` loops look pretty standard, `break` breaks out of while.
* `for` loops look pretty standard, execpt for:
  * you can loop  over different vectors using `for i = 1:2, j = 3:4`, now 
    that is a really good alternative to `purrr::map2` and avoiding nested 
    for loops
  * you can loop over using a tuple using `zip`: 
    `for (j, k) in zip([1 2 3], [4 5 6 7])`
* `1:5` syntax can be used like in R for indices
* You can use `\epsilon` or `in` 

### Exception Handling

* There are a bunch of built-in exceptions: 
  * [here](https://docs.julialang.org/en/v1/manual/control-flow/#Built-in-Exceptions)
* You can define also: `struct MyCustomException <: Exception`
* Throw exceptions using `throw(DomainError(x, "argument is not part of domain"))`
* `showerror` method on that error type allows you to define how that error 
  will be displayed


