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

* **Extracting the type parameter from a super-type** - You can use this 
  method to extract the type inside a parameterized type:

```julia
eltype(::Type{<:AbstractArray{T}}) where {T} = T
```

* **Building a similar type with a different type parameter** - Use 
  `Base.similar` to create a mutable array with the given element type and 
  size. Use `Base.copyto!` in order to always create a copy.
* **Iterated dispatch** - You can dispatch first on the outer container then 
  continue down the dispatch tree (similar to single dispatch).
* **Trait-based dispatch (Holy trait)** - This stuff is really getting over my 
  head now haha. 

```julia
map(f, a::AbstractArray, b::AbstractArray) = map(Base.IndexStyle(a, b), f, a, b)
# Base.IndexStyle(a, b) returns a trait that is going to return the best way 
# to index that particular set of parameters, and then you can just fall back 
# to the default implementation so you don't have to keep a tree.
map(::Base.IndexCartesian, f, a::AbstractArray, b::AbstractArray)
```

* **Output-type computation** - `Base.promote_type` decides the output type 
  of the computation for the basic types. 
* **Separate convert and kernel logic** - to reduce compile time is to isolate
  the conversion logic and the computation. 
* **Parametrically-constrained Varargs methods** - use the same parameter in 
  the operated objected and the varargs so you can constrain the methods

### Some function gotchas

* Note: keyword arguments do not operate on multiple dispatch
* Note: default arguments are going to bne overridden if you specify a more 
  specific implementation afterwards.

### Function-like objects

* You can turn a type into a function that operates!
* This is very similar to R where functions are first class objects.

### Empty generic functions 

* Use this to define a specific interface: `function emptyfunc end` 

### Method design and the avoidance of ambiguities

* Ambiguities can be hard to deal, here are some alternatives to just deifining
  a more specific method:
  * `Tuple` and `NTuple` arguments - in the empty case they are ambiguous as 
    to type so you can either define one on empty type or restrain your
    NTuple arguments to only where N > 1
  * Orthogonalized design - nest the methods
  * Dispatch on one argument at a time (Single dispatch)
  * Don't define methods that dispatch on specific element types of 
    abstract containers, instead you should just define on a generic method and 
    construct a conceptual tree before specializing.
  * When recursing avoid relying on default arguments because you can cause 
    an infinite loop.

## Constructors

* It's just an automatically generated function that accompanies a struct.
* "Outer constructors" - You can create new methods for it just like any other 
  function
  * Use the same value for fields
  * Add default values
* "Inner constructors"
  * needed for 2 use cases:
    1. enforcing invariants (validations)
      * ensures that no object (if immutable) will violate the invariant
      * you can't enforce with outer constructors because ultimately they 
        must call an inner constructor
    2. allowing construction of self-referential objects
      * for recursive applications, you can call `new` without all the fields
      * you can create a self referential object like this
  * declared inside the block of a type declaration
  * special access to a local function called `new` that is the default 
    constructor

```julia 
struct OrderedPair
  x::Real
  y::Real
  OrderedPair(x,y) = x > y ? error("out of order") : new(x,y)
end
```

  * above object is now constraint to strictly decreasing
  * it does not enforce this if the struct is mutable, so only immutable 
    structs will have some sort of guarantee.
  * Best practices for constructors:
    * as few inner constructors as possible
    * take all arguments explicitly and enforce essential error checking
    * provide ocnveniences as outer construtors
* Incomplete initialization
  * For recursion
* Parametric constructors
  * Use the `promote` function heavily so that you can rationalize with only 1 
    type.

## Conversion and Promotion

* Two approaches to promotion:
  1. Automatic promotion for built-ins (Perl, Python) 
    * 1 + 1.5 is automatically promoted to floating point  
  2. No automatic promotion
    * quite inconvenient
* Julia falls into the no automatic promotion (#2) but implements some 
  polymorphic multiple dispatch as a special application. It can be edited
  by the user if they so choose and user-defined types can participate.

### Conversion 

* Just call the constructor on the object to be converted.
* `convert(::DataType, x)` function is the function on which we add conversion
  methods.
* Julia does not aurtomatically convert between strings and numbers.
* Conversion differs from construction in:
  1. Mutable collections
  2. Where it's not really a conversion
  3. Wrapper types - types that wrap other value.
  4. Constructors that don't rteturn instances of their own type.

### Defining new conversions

* It's just a metter of defining a method for `convert`
* Only do this if implicit conversion is safe! Otherwise, rely on the 
  constructor functions being explicitly called.

### Promotion

* Standardization of types prior to an operation.
* Handled by the `promote()` method - **but** you don't define the rules on 
  `promote` but on the `promote_rule(::DataType, ::DataType)` which doesn't
  take the actual values but the datatypes. This is symmetric already so you
  don't need to define the flipped datatypes. This feeds into a function called
  `promote_type` that you can then use to actually determine what type the 
  value will end up being.
* Aiming to be as lossless as possible.

## Interfaces

* Iteration interface
  * defining an `iterate` method will allow you to use 
    1. `for` loops
    2. `in` operator
    3. `mean`, `std` etc
  * defining `eltype` method will allow us to know more things like creating
    specialized iterable code that's faster
  * defining `length` allows us to preallocate and stuff like that
  * defining `firstindex` and `lastindex` allow us to specify the first and 
    last valid indices so we can use the `begin` and `end` indices
* `AbstractArray` interface
  * `IndexStyle` is important to define for efficiency
  * This interface is extremely rich, simply defining:
    `struct SquaresVector <: AbstractArray{Int, 1}` is enough to make it 
    iterable, indexable, and completely functional.
* Strided Arrays - a lot over my head
* Customizing broadcasting - also over my head but I can see how that can be 
  super useful for building actual machine learning models.
  
## Modules

* would be the whole package scope in an R package I suppose
* key properties are: 
  1. separate namespaces - avoids conflicts in function names
  2. has `import` and `export` for defining what it needs and what it provides
     other modules (by default, there is no private namespace)
  3. Modules can be precompiled for faster loading and contain code for 
     running initialization.
* module code is typically organized into files and then read in using 
  `include("file1.jl")`. 
* although related `include` is just adding the code in the file into wherever 
  it is and modules can be composed around or within that any which way.
* `parentmodule` finds the module that an object is contained
* You can reserve variable names by declaring `global x` so that it cannot be 
  modified from outside the module.
* `using` loads all exports into the `Main` namespace, whereas `import` just
  brings the module name into scope, so you'd need to quality everything in 
  there in order to use it. 
  * `using Module: name1, name2` only brings specific names into global scope
    and the module name will not be in scope unless you also include it in 
    the names list. You can't add methods to a function without a namespace 
    (as it's "using")
  * `import Module: name1, name2` brings in the specific names and also 
    allows you to attach methods (usually done in other modules)
* You can use `as` to work around namespace conflicts like 
  `import CSV: read as rd` or `importBenchmarkTools as BT`. This is not 
  compatible with `using`/.
* When modules export the same name:
  1. Use qualified name especially when they mean different things
  2. use the keyword to reanme one or both with unqiue identifiers.
  3. If they do share the same meaning then there is a unifier base package.
* `Base` and `Core` are in the modules unless you define `baremodule`
* `import .Module` imports a module defined in the current scope, 
  `import ..Module` imports a module defined in the parent module and so on.
  `..` is essentially a "sibling" module.

### Module initialization and pre-compilation

* Whenever something is `import`-ed or `using`-ed the modulem is precompiled.
  Trigger manually using `Base.compilecache`
* Put `__precompile__(false)` in the module file at the top to prevent a module
  from being precompiled. 
* Don't precompile any external dependencies but rather define them at 
  runtime using the `__init__()` function, like external C libraries and global 
  constants that containe pointers returned by external library
* Dictionaries can be safe to precompile if the key is generally standard types,
  not weird ones like `Function` or `DataType` or user-defined types without 
  a defined hash method.

## Documentation

* Docstrings basically, interpreted as Markdown handled by `Markdown.jl`.
* Standard for a docstring:

```julia
"""
    bar(x[, y]) # function signature with indent, optional with [], kwargs with ;
  
Imperative format of title ending with a period.

Additional details in a second paragraph that explains more implem details. Be 
concise and don't repeat yourself. 

# Arguments 

This part is only necessary if it's a complex function and those with kwargs.

See also: [`bar!`](@ref) # Hints to related functions 

# Examples

Written as doctests whenever possible

\```jldoctest 
julia> code to run
output that matches the output exactly. Use [...] to truncate the output.
\```
"""
```

* `code` and ``LATEX``
* 92 characters wide max
* Function implementation for custom types can be in an Implementation section.
  Intended for developers rather than users.
* Long docstrings can be split off to an extended help header tahn can be 
  called explicitly by adding ??function rather than ?function
* Ideally only the generic function needs to be documented, no need to 
  document the individual methods, unless the behavior differs explicitly.
* `@doc` macro allows you to insert expressions into the documentation. 
* Use `$($name)` to use string interpolation in docstrings
* You can define a method on `Docs.getdoc` to be able to operate on that 
  type and access the data for it.
* If you alias something, just document the original so that both can have 
  the documentation.
* You can add a docstring to two things separated by a comma.

## Metaprogamming

* Now this is going to be exciting!
* All this (including R) inherits from Lisp.
* Expressions have two parts (type `Expr`, `Expr(:call, :+, 1, 1)`)
  * head: indicating the type of expression - `exp.head`
  * args: the contents of the expression - `exp.args`
* Expressions can be nested and manipulated
* Symbols are represented as `:symbol`
* `Symbol("func", 10)` turns into `func10` so you can manipulate the 
  symbol with strings.
* Quoting
  * creation of expression objects 
  * :(a + b * c + 1) turns the quote string into an expression 
* Interpolation
  * manipulating the expression objects without `Expr` using `$`
  * `ex = :($a + b)` turns into `:(1 + b)` because a is evaluiated and 
    `a = 1`.
  * You can also do splatting interpolation through `$(xs...)`. 
    `:(f(1, $(args...)))` turns into `:(f(1, x, y, z))`
  * the `$` is kinda like `!!` in R and the splatted one is `!!!`
  * You can nest down levels of quoting through `$$$....`
  * `QuoteNode` avoids interpolating the :$
* Evaluation
  * You can execute the expression using `eval`
  * `Module.eval` evaluates inside the global scope of the `Module`
* You can define functions that manipulate these expressions
* Macros
  * including generated code in the final body of a program
  * maps a tuple of arguments to a returned expression which is compiled 
    directly instead of at runtime
  * Think of the result of the macro being inlined into the code by the 
    compiler and then that being compiled.
  * Inspect the expressiong using `macroexpand` 
      * `macroexpand(Main, :(@sayhello "Troy"))` - you need to include 
        the module in which the macro will be evaluated.
  * Macros receive the `__source__` and `__module__` argumens which contain 
    the line number of the invocation and the information about the expansion 
    module (like existing bindings).
  * Macros rename local variabels to avoid name clashes with the module scope.
    You can use `esc(ex)` to escape this and ignore hygiene.
  * Macros are also functions and can therefore take advantage of multiple
    dispatch, but they dispatch based on types of the AST not the evaluated
    values of the expressions

```julia
macro sayhello()
  return :( println("Hello there!") )
end
```

* Boilerplate code can be generated programmatically using `eval` on a 
  `quote ... end` with interpolation. You can use the eval/quote pattern
  using the `@eval macro`

### Non-standard string literals

* You can define string literals like `r"^\s"` which is a regex or `b"..."` 
  which is a byte array literal.
* You can also take advantage of this by defining a macros that is of the form 
  `{...}_str` which allows you to define a string literal `{...}"..."`.

### Generated functions

* You can define using `@generated` and the function should return a quoted
  expression. 
* I don't get this at all haha
* There's also optionally generated functions.

