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

x = 2
y = 2

x == y ? "equal" : "not equal"
x != y ? "not equal" : "not not equal"

throw(DomainError(x, "argument is not part of domain"))

typeof(DomainError)
typeof(DomainError(nothing))