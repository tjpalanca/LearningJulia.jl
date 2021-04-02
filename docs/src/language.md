# Julia Language

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
* There's a lot of reference to language design here and I feel like I'm also
  learning about it as I read through how to actually use Julia.

# Reading through the Julia Language Manual

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
* How do you decide whether a type can be immutable or not? Ask yourself if 
  two objects that have exactly the same fields are identical. If they are,
  it's usually an indicator that you want an immutable type.
* All these declared types are of type `DataType`

### Type Unions

* You moosh together two types and anything inherits from that like so:
  `IntOrString = Union{Int, AbstractString}`
* `Union{T, Nothing}` is essentially a nullable type because it can be the
  special value `nothing`.

### Parametric types

* You can declare a parametric type like so:

```julia
struct Point{T}
  x::T
  y::T
end
```

* `Point` is also a type containing any of its parameterized equivalents as 
   subtypes.
* `Point{Float64}` is not a subtype of `Point{Real}`, so in order to define a 
  method that allows dispatching on both, use this form: 

```julia
function norm(p::Point{<:Real}) end 
```

* `Point{<:Real}` is really just a Point that is a `UnionAll` of all the 
  subtypes of `Real`, which explains how it works. You can also do 
  `Point{>:Int}` to get all the supertypes of `Int`. 
* If you use the constructor in a way, it already defins the parameteric types,
  i.e. calling `Point(1.0, 2.0)` will generate a `Point{Float64}` automatically.
* You can declare types as subtypes of parametric abstract types just like 
  any other type.

### Tuple Types

* Function arguments are tuples, which are really like immutable structs that 
  are parameterized by the type of each arugment, but some differences:
  1. Tuple types can have any number of parameters 
  2. Typle types are covariant, so `Tuple(Int)` is a subtype of `Tuple(Any)`.
  3. Types do not have field names and are accessed by index.
* `(1, "foo", 2.5)` is a tuple
* Tuples may have `Vararg{T, N}` which can match 0 to N arguments (Inf if `N`
  is omitted. There is a convenience `NTuple{N,T}` to represent a Tuple that has
  N elements of type T.

### Named Tuple types 

* Is this the named list in R?
* It has a tuple of symbols and a tuple of field types:
  `NamedTuple{(:a, :b), Tuple{Int64, String}}
* You can use `@NamedTuple` to provide a more convenient struct-like syntax:

```julia
@NamedTuple begin 
  a::Int
  b::String 
end
```

### UnionAll Types

* `Array{<:Integer}` is effectively `Array{T} where T<:Integer`.
* You can short form a type definition using: `Vector{T} = Array{T, 1}`

### Singleton Types

* Immutable composite types with no fields: `struct NoFields end`

### Operations on Types

* `isa(x, y)` or `x <: y` checks for subtypes
* `typeof()` returns the type of its argument
* `supertype()` returns the supertype of its argument

### Custom pretty-printing

* Overload the `show` function: `Base.show(io::IO, z::Polar)`
* You can also change the output based on the MIME type:
  `Base.show(io::IO, ::MIME"text/plain", z::Polar{T})`

### Value types

* You can dispatch on the actual value of a type using the `Val` keyword, but
  this is likely to be not idiomatic.

## Methods

> To facilitate using many different implementations of the same concept 
> smoothly, functions need not be defined all at once, but can rather be defined
> piecewise by providing specific behaviors for certain combinations of 
> argument types and counts. 

* A "function" is 
  * an object that maps a tuple of argyuments to a return value or throws 
    an exception if no appropriate value can be returned.
  * a conceptual operation that may be abstract
* A "method" is 
  * a specific concrete implementation or behavior of a fucntion.
  * a function defined is usually just one method
* Even if the concrete implementation is quite different, well designed dispatch
  will appear very coherent from the outside.
* Multiple dispatch (like R's S4 but more deliberately made lol)
  * Most specific (lower on the type tree) will be used.
* Ambiguities in selecting most specific type raise an error.
* Just define a function but with type annotations and voila it's a method of 
  that function (already that's less typing than R)
* All conversion in Julia is explicit (also different from R)
* Use `methods(f)` to figure out the methods attached to the generic
* No type means the `Any` apex type.

### Parametric Methods

* you can also define methods like so: `same_type(x::T, y::T) where {T}` which 
  applies whenever both `x` and `y` are of the same type.
* You can also constrain those parameters by doing `where {T<:Real}`

### Redefining methods

* You cannot immediately use new method definitions as soon as you defined them
  usually in the same expression; use `Base.invokelatest(f)` to get around this.

### Design patterns

* **Extracting the type parameter from a super-type** 