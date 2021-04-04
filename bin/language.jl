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

# Methods

AbstractArray
eltype(::Type{<:AbstractArray{T}}) where {T} = T
eltype(AbstractArray{Real})
eltype(::Type{<:AbstractArray{H}}) where {H} = H
eltype(AbstractArray{AbstractString})

X = [1, 2, 3]
typeof(X)
similar(X, Float64, 10)

struct Polynomial{R}
    coeffs::Vector{R}
end

function(p::Polynomial)(x)
    v = p.coeffs[end]
    sum(p.coeffs .* x)
    return v
end 

(p::Polynomial)() = p(5)

p = Polynomial([1, 10, 100])
p(3)

mutable struct SelfReferential
    obj::SelfReferential
    SelfReferential() = (x = new(); x.obj = x)
end

A = SelfReferential()
A.obj

# Interfaces

## Iteration

using Compose

struct Circles
    count::Int
end 

Base.iterate(C::Circles, state=1) = 
    state > C.count ? nothing : (Compose.circle(), state + 1)

for item in Circles(7)
    println(item)
end

# Metaprogramming 

prog = "1 + 1"
exp = Meta.parse(prog)
typeof(exp)

# This is the first part which identifies the kind of expression
exp.head

# This is the second part whihc calls the arguments 
exp.args

# Just like in R you can reconstruct them
Expr(:call, :+, 1, 1)

# You can eval the exp
Meta.eval(exp)

# Dump it to see the whole thing 
dump(exp)

exp2 = :(x + y * 2)
Meta.@dump :(x + y * 2)

# Macros

macro sayhello(name)
    return :( println("Hello there, ", $name) )
end

@sayhello "Troy"

macroexpand(Main, :(@sayhello "Troy"))

zeros((2, 3))

[1, 2, 3]

eltype(["Hello"])

x = rand(8)
[ 0.25*x[i-1] + 0.5*x[i] + 0.25*x[i+1] for i=2:length(x)-1 ]

sum(1/n^2 for n=1:1000)

A = reshape(1:32, 4, 4, 2)
page = A[:,:,1]
page[[
    CartesianIndex(1,1),
    CartesianIndex(2,2),
    CartesianIndex(3,3),
    CartesianIndex(4,4)
]]
page[CartesianIndex.(axes(A, 1), axes(A, 2))]
A[CartesianIndex.(axes(A, 1), axes(A, 2)), :]

B = [1, 2, 3, 4]
B[[true, false, true, true]]

C = [1, 2, 3]
D = [3, 4, 5]
C + D # This works
sin(C + D) # This does not work!
sin.(C + D) # This works

E = [4, 5, 6, 7, 8, 9]
C + E # This no longer works
C .+ E # This now works
min.(C, D)

# Missing Values

typeof(missing)
missing === missing

Array{Union{Missing, String}}

# Networking and Streams

write(stdout, "Hello World");
read(stdin, Char)
readline(stdin)
for line in eachline(stdin)
    print("Found $line")
end