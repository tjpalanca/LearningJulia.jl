# Functions

f(x) = x + 2
f(2)

g(x) = x - 2

(f ∘ g)(3)

begin 
    x = 1
    y = 2
    x + y
end

h = (x) -> x / 2

h(3)

# Conditionals

x = 2
y = 2

x == y ? "equal" : "not equal"
x != y ? "not equal" : "not not equal"

# Exceptions

throw(DomainError(x, "argument is not part of domain"))

typeof(DomainError)
typeof(DomainError(nothing))

error("negative x not allowed")

# Types

struct Foo
    bar 
    baz::Int
    qux::Float64 
end

Foo("Hello World", 23, 1.5)
Foo("Hello World", 23.5, 1.5)

typeof(Foo)

    IntOrString = Union{Int, AbstractString}

1::IntOrString

"Hello!!"::IntOrString

1.53::IntOrString

struct Location{T}
    lon::T
    lat::T
end

Location{Float64} <: Location{Real}
Location{Float64} <: Location{<:Real}
Location{Real} <: Location{>:Float64}

struct LocationReal{T<:Real} 
    lon::T
    lat::T
end 

LocationReal("Hello World", "Long")
LocationReal(1.0, 1.0) |> typeof
LocationReal(1, 2) |> typeof

struct NoFields end
NoFields() == NoFields()
NoFields() === NoFields()
Base.issingletontype(NoFields)

mutable struct MutableNoFields end 
MutableNoFields() == MutableNoFields()
MutableNoFields() === MutableNoFields()

