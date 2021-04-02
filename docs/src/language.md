# Julia Language Features

```@contents
Pages = ["language.md"]
Depth = 2
```
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

## Variable Scope

* Global and local scope
* `if` and `begin/end` blocks do not introduce new scopes
* Julia uses _lexical scoping_ which means that the function's scope inherits
  from where the function was defined (like in R). You can refer to variables 
  outside the scope in the parent.
* Constants can be defined by `const` this does not allow changing the value 
  after; this really helps the compiler.
* Each module intorduces a new global scope that is a separate world form other
  modules (oh boy this is where we can finally resolve the problem of too many
  conflicting names in R). `using` and `import` allow transportation of objects
  between those scopes. You can copy but you cannot insert and modify between 
  modules.
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
* `stop()` in R would be `error` throwing an `ErrorException` 
* `try` - `catch` - `end` is implemented like so:

```julia
try 
  sqrt("ten")
catch e # this e is the exception 
  println("Needs to be numeric not a string")
end 
```

* can do inline try catch using `try condition catch e; expression end`
* `finally` can be added to ensure that things are finalized (close db or file 
  connections and whatnot).

## Types

### General type system

* Julia's type system is ultimately dynamic but gains compiler advantages from
  type annotations.
* Type annotations serve 3 purposes:
  1. take advantage of Julia's powerful multiple-dispatch mechanism
  2. improve human readability
  3. catch programming errors
* Why can't you inherit from a concrete type?
  * inherit behavior (methods) more important than inheriting structure
    * but I mean why not both?
  * there are some difficulties with inheriting structure (? - unanswered)
* Salient aspects:
  * No divison between object and non-object values
  * No compile time type
  * Only values have types not variables

### Type declarations

* `::` operator: "is an instance of"
* `(1 + 2)::Int` is a type assertion 
* `x::Int = 1` is a type restriction of that variable
* `function sinc(x)::Float64` is a type restriction on the result

### Abstract types

* Cannot be instantiated
* `abstract type «name» end`
* Default supertype is `Any` - all objects are instances of
* Bottom type is `Union{}` nothins is a `Union{}` and all are supertypes
* `<:` is operator for "is a subtype of"

### Primitive types

* You can declare these as bits but why?
* `primitive type <<name>> <: <<supertype>> <<bits>> end`

### Composite Types

* composed of primitive types, called records or   structs or objects
* Julia composite types cannot have methods in them, the methods are outside
* By default two constructors area created which is just a 
  function with the elements of the struct as arguments, and one that takes
  `Any` type and attempts to do the conversion.
* Structs are immutable (like pretty much anything in R except environments) 
  primarily for performance and secondarily for readability. They can be 
  made mutable using a `mutable struct` keyword though.
* 