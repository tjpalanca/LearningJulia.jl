module GenerativeArt

using Compose

function main() 
    compose(
        context(),
        rectangle(),
        fill("tomato"),
        (context(), circle(), fill("bisque"))
    )
end 

function introspect()
    bisque = main()
    Compose.introspect(bisque)
end

end