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

