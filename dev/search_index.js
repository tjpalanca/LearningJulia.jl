var documenterSearchIndex = {"docs":
[{"location":"bayesian/#Bayesian-Modeling","page":"Bayesian Modeling","title":"Bayesian Modeling","text":"","category":"section"},{"location":"bayesian/","page":"Bayesian Modeling","title":"Bayesian Modeling","text":"Source: bin/Bayesian.jl","category":"page"},{"location":"bayesian/","page":"Bayesian Modeling","title":"Bayesian Modeling","text":"Bayesian modeling is an interest of mine ever since I read  [Towards a Principled Bayesian Workflow] by Michael Betancourt, so I'm keen to see if Julia has robust libraries for Probabilistic Programming like Stan, PyMC3, greta.","category":"page"},{"location":"bayesian/#Turing.jl","page":"Bayesian Modeling","title":"Turing.jl","text":"","category":"section"},{"location":"bayesian/","page":"Bayesian Modeling","title":"Bayesian Modeling","text":"This looks the most complete so far","category":"page"},{"location":"smart_home/#Smart-Home","page":"Smart Home","title":"Smart Home","text":"","category":"section"},{"location":"smart_home/#SmartHomy.jl","page":"Smart Home","title":"SmartHomy.jl","text":"","category":"section"},{"location":"dev_env/#Development-Environment","page":"Development Environment","title":"Development Environment","text":"","category":"section"},{"location":"dev_env/#VS-Code-(coder-server)-with-Julia-Extension","page":"Development Environment","title":"VS Code (coder-server) with Julia Extension","text":"","category":"section"},{"location":"dev_env/","page":"Development Environment","title":"Development Environment","text":"I am coming from RStudio so I am very, very spoiled. \nI like VS Code so I decided to set up a cloud-based VS code instance using  the cdr/code-server docker image and layer R, Python, and Julia onto the  image. \nI am using Julia 1.6 as it mainly solves a lot of Time to First  Plot problems which I suspect will cause me issues. \nAfter watching some of the JuliaCon videos on YouTube, I was able to set up the Julia extension with inline results and some cool stuff like workspaces and environments. \nIt feels like RStudio! Although, the Language Server can  sometimes choke up for no apparent reason, and it takes a while for  autocomplete to kick in after loading a package using using.\nSome of the great features are on version control, particularly with the  Git Lens extensions. I can see how more software engineering-types will be  attracted to the Julia ecosystem compared to R which attracts domain  experts going in the opposite direction.\nI'm pretty sure I can find a VS code extension for anything I need; it's an  amazingly rich ecosystem!\nInline results are something else! Much better than a notebook interface and  better than also constantly looking at the console.","category":"page"},{"location":"dev_env/#OhMyREPL.jl","page":"Development Environment","title":"OhMyREPL.jl","text":"","category":"section"},{"location":"dev_env/","page":"Development Environment","title":"Development Environment","text":"That's cool! Packages can modify the REPL to a deep level. \n~/.julia/config/startup.jl is the equivalent of the .Rprofile file","category":"page"},{"location":"dev_env/#Pluto.jl","page":"Development Environment","title":"Pluto.jl","text":"","category":"section"},{"location":"dev_env/","page":"Development Environment","title":"Development Environment","text":"This is an interesting notebook interface that I want to take a look at.\n","category":"page"},{"location":"ecosystem/#Package-Ecosystem","page":"Ecosystem","title":"Package Ecosystem","text":"","category":"section"},{"location":"ecosystem/","page":"Ecosystem","title":"Ecosystem","text":"I'm spoiled by CRAN. It's a pain to submit and maintain but it does result  in such a good user experience.\nPkg is a great package manager with environments built in! What a relief  as python's venv, conda, etc was difficult to grok.\nI'm seeing that the Pkg registration process is quite liberal, so now I'm  struggling to find a way to easily gate the quality of packages and the  updated-ness of packages I want to use.","category":"page"},{"location":"ecosystem/","page":"Ecosystem","title":"Ecosystem","text":"","category":"page"},{"location":"web/#Web-Development","page":"Web Development","title":"Web Development","text":"","category":"section"},{"location":"web/#Basic-Packages","page":"Web Development","title":"Basic Packages","text":"","category":"section"},{"location":"web/#HTTP.jl","page":"Web Development","title":"HTTP.jl","text":"","category":"section"},{"location":"web/","page":"Web Development","title":"Web Development","text":"This seems to be one of the most fundamental web libraries in Julia.","category":"page"},{"location":"web/#WebIO.jl-ecosystem","page":"Web Development","title":"WebIO.jl ecosystem","text":"","category":"section"},{"location":"web/#Mux.jl","page":"Web Development","title":"Mux.jl","text":"","category":"section"},{"location":"web/#Genie.jl-ecosystem","page":"Web Development","title":"Genie.jl ecosystem","text":"","category":"section"},{"location":"web/#Dance.jl","page":"Web Development","title":"Dance.jl","text":"","category":"section"},{"location":"databases/#Databases","page":"Databases","title":"Databases","text":"","category":"section"},{"location":"databases/","page":"Databases","title":"Databases","text":"Source: scripts/Database.jl Using: LibPQ.jl, Octo.jl, Stipple.jl","category":"page"},{"location":"databases/","page":"Databases","title":"Databases","text":"My favorite database is PostgreSQL, so I decided to see how I can access this database.\nThere's a standard interface for connecting to databases, but  sadly that doesn't seem to be available for Postgres, instead I'm redirected to the libpq interface LibPQ.jl","category":"page"},{"location":"databases/#LibPQ.jl","page":"Databases","title":"LibPQ.jl","text":"","category":"section"},{"location":"databases/","page":"Databases","title":"Databases","text":"Is there something more high level that I can use? ","category":"page"},{"location":"databases/#Reading","page":"Databases","title":"Reading","text":"","category":"section"},{"location":"databases/","page":"Databases","title":"Databases","text":"With this, I'm able to to make queries and execute them, it's quite low level but it works for my standard Postgres installation.\nI'm able to transpose this into a DataFrame. I don't quite understand the many different tabular structures yet (I'm used to the built-in dataframe  in R), but I can see how that works. See Data Frames.","category":"page"},{"location":"databases/#Writing","page":"Databases","title":"Writing","text":"","category":"section"},{"location":"databases/","page":"Databases","title":"Databases","text":"DDL Statements have to be written manually\nTransactions have to be written manually (but easily wrapped)\nYes I can insert stuff, but still need SQL knowledge","category":"page"},{"location":"databases/#ODBC.jl","page":"Databases","title":"ODBC.jl","text":"","category":"section"},{"location":"databases/","page":"Databases","title":"Databases","text":"This is a more standard interface, but it's less feature rich. I'm skipping  this for now but this might be the way to get to lesser known DBs.","category":"page"},{"location":"databases/#Octo.jl","page":"Databases","title":"Octo.jl","text":"","category":"section"},{"location":"databases/","page":"Databases","title":"Databases","text":"It's a SQL Query DSL in Julia. Amazing, is this going to be like the  {dbplyr} package in R? Making a decent data access layer is soooooo hard!\nOkay so now I have to actually use structs\nIt supports Postgres, and MySQL and SQLite too!\nOkay I was able to query the information schema using a basic query tool.  I'm really not sure why I have to define a struct\nReally these function documentations are a little over my head: for example: Schema.model( will surface CoreType where T or something which does not really give me information about what arguments to place). May just be  that we need to add more docstrings or something?\nSQL keywords in the DSL part need to be capitalized\nI was able to query a bit and get in tune with the DSL, seems ok as a web app backend ORM but not for data analysis.","category":"page"},{"location":"databases/#Query.jl","page":"Databases","title":"Query.jl","text":"","category":"section"},{"location":"databases/","page":"Databases","title":"Databases","text":"The package currently provides working implementations for in-memory data sources, but will eventually be able to translate queries into e.g. SQL. There is a prototype implementation of such a \"query provider\" for SQLite in the package, but it is experimental at this point and only works for a very small subset of queries.","category":"page"},{"location":"databases/","page":"Databases","title":"Databases","text":"This one is super promising but isn't implemented yet.","category":"page"},{"location":"language/#Julia-Language-Features","page":"Language","title":"Julia Language Features","text":"","category":"section"},{"location":"language/","page":"Language","title":"Language","text":"Pages = [\"language.md\"]\nDepth = 2","category":"page"},{"location":"language/#General-observations","page":"Language","title":"General observations","text":"","category":"section"},{"location":"language/","page":"Language","title":"Language","text":"I love the named slurping and splatting, an improvement of the R syntax\nIt looks like math! Very little cognitive load on translating some work.\nHowever, the whole multiple dispatch thing, when I watch videos looks amazing, but when I try to implement makes my brain hurt. I suffer from the curse of seeing OOP in Python and R6 in R. S3 is quite similar but is so much  simpler because it's single dispatch.\nSymbols and strings are separate - amaze! Metaprogramming has been something  that is quite easy in R and I suspect quite easy in Julia too with the macros.\nDo-block syntax - interesting, the function is first and then the iterable in  Julia's map() as opposed to R's purrr::map().","category":"page"},{"location":"language/#Variable-Scope","page":"Language","title":"Variable Scope","text":"","category":"section"},{"location":"language/","page":"Language","title":"Language","text":"Global and local scope\nif and begin/end blocks do not introduce new scopes\nJulia uses lexical scoping which means that the function's scope inherits from where the function was defined (like in R). You can refer to variables  outside the scope in the parent.\nConstants can be defined by const this does not allow changing the value  after; this really helps the compiler.\nEach module intorduces a new global scope that is a separate world form other modules (oh boy this is where we can finally resolve the problem of too many conflicting names in R). using and import allow transportation of objects between those scopes. You can copy but you cannot insert and modify between  modules.","category":"page"},{"location":"language/#Functions","page":"Language","title":"Functions","text":"","category":"section"},{"location":"language/","page":"Language","title":"Language","text":"Function composition and piping!\nComposition operator (\\circ) can combine two functions together\nPiping is using the pipe (|>) operator \nDot syntax for vectorizing is very interesting.  \nVectorizing is not required for performance, but they're still prettier\nAny julia function can be applied by adding a . after like .sin(V), or before the operator in the case of binary operators like .+\nAmazing yet again!\nThis is just syntactic sugar for the broadcast function modifier\nNested brodcasts are joined together in a syntactic loop.\nYou can pre-allocate using the dotted assignment .=\nTo avoid having too many dots then you can use the @. macro to add  dots to every singe funciton call in that line.\nAnonymous functions use arrow like in JS: (x) -> x + 2","category":"page"},{"location":"language/#Control-Flow","page":"Language","title":"Control Flow","text":"","category":"section"},{"location":"language/#Expressions","page":"Language","title":"Expressions","text":"","category":"section"},{"location":"language/","page":"Language","title":"Language","text":"Expressions using begin and end - no brackets so need this, you can also  separate into lines and use parens (x = 1; y = 2; x + y)","category":"page"},{"location":"language/#Conditionals","page":"Language","title":"Conditionals","text":"","category":"section"},{"location":"language/","page":"Language","title":"Language","text":"if, elseif, else, end - nothing else to add simple enough\nIf blocks do not have their own variable scope (same as R)\nThey can also return a value like in R\nThey must return a boolean\nTernary operator can be used condition ? iftrue: iffalse\n&& and || short circuit the expression like in R, so you can use it  to define some backup values or substitute the ternary operator\n& and | evaluate both arguments","category":"page"},{"location":"language/","page":"Language","title":"Language","text":"function fact(n::Int)\n  n >= 0 || error(\"n must be non-negative\")\n  n == 0 && return 1\n  n * fact(n-1)\nend","category":"page"},{"location":"language/#Iteration","page":"Language","title":"Iteration","text":"","category":"section"},{"location":"language/","page":"Language","title":"Language","text":"while loops look pretty standard, break breaks out of while.\nfor loops look pretty standard, execpt for:\nyou can loop  over different vectors using for i = 1:2, j = 3:4, now  that is a really good alternative to purrr::map2 and avoiding nested  for loops\nyou can loop over using a tuple using zip:  for (j, k) in zip([1 2 3], [4 5 6 7])\n1:5 syntax can be used like in R for indices\nYou can use \\epsilon or in ","category":"page"},{"location":"language/#Exception-Handling","page":"Language","title":"Exception Handling","text":"","category":"section"},{"location":"language/","page":"Language","title":"Language","text":"There are a bunch of built-in exceptions: \nhere\nYou can define also: struct MyCustomException <: Exception\nThrow exceptions using throw(DomainError(x, \"argument is not part of domain\"))\nshowerror method on that error type allows you to define how that error  will be displayed\nstop() in R would be error throwing an ErrorException \ntry - catch - end is implemented like so:","category":"page"},{"location":"language/","page":"Language","title":"Language","text":"try \n  sqrt(\"ten\")\ncatch e # this e is the exception \n  println(\"Needs to be numeric not a string\")\nend ","category":"page"},{"location":"language/","page":"Language","title":"Language","text":"can do inline try catch using try condition catch e; expression end\nfinally can be added to ensure that things are finalized (close db or file  connections and whatnot).","category":"page"},{"location":"language/#Types","page":"Language","title":"Types","text":"","category":"section"},{"location":"language/#General-type-system","page":"Language","title":"General type system","text":"","category":"section"},{"location":"language/","page":"Language","title":"Language","text":"Julia's type system is ultimately dynamic but gains compiler advantages from type annotations.\nType annotations serve 3 purposes:\ntake advantage of Julia's powerful multiple-dispatch mechanism\nimprove human readability\ncatch programming errors\nWhy can't you inherit from a concrete type?\ninherit behavior (methods) more important than inheriting structure\nbut I mean why not both?\nthere are some difficulties with inheriting structure (? - unanswered)\nSalient aspects:\nNo divison between object and non-object values\nNo compile time type\nOnly values have types not variables","category":"page"},{"location":"language/#Type-declarations","page":"Language","title":"Type declarations","text":"","category":"section"},{"location":"language/","page":"Language","title":"Language","text":":: operator: \"is an instance of\"\n(1 + 2)::Int is a type assertion \nx::Int = 1 is a type restriction of that variable\nfunction sinc(x)::Float64 is a type restriction on the result","category":"page"},{"location":"language/#Abstract-types","page":"Language","title":"Abstract types","text":"","category":"section"},{"location":"language/","page":"Language","title":"Language","text":"Cannot be instantiated\nabstract type «name» end\nDefault supertype is Any - all objects are instances of\nBottom type is Union{} nothins is a Union{} and all are supertypes\n<: is operator for \"is a subtype of\"","category":"page"},{"location":"language/#Primitive-types","page":"Language","title":"Primitive types","text":"","category":"section"},{"location":"language/","page":"Language","title":"Language","text":"You can declare these as bits but why?\nprimitive type <<name>> <: <<supertype>> <<bits>> end","category":"page"},{"location":"language/#Composite-Types","page":"Language","title":"Composite Types","text":"","category":"section"},{"location":"language/","page":"Language","title":"Language","text":"composed of primitive types, called records or   structs or objects\nJulia composite types cannot have methods in them, the methods are outside\nBy default two constructors area created which is just a  function with the elements of the struct as arguments, and one that takes Any type and attempts to do the conversion.\nStructs are immutable (like pretty much anything in R except environments)  primarily for performance and secondarily for readability. They can be  made mutable using a mutable struct keyword though.","category":"page"},{"location":"computation/#Computation","page":"Computation","title":"Computation","text":"","category":"section"},{"location":"computation/#Dagger.jl","page":"Computation","title":"Dagger.jl","text":"","category":"section"},{"location":"computation/#Distributed.jl-and-Ecosystem","page":"Computation","title":"Distributed.jl and Ecosystem","text":"","category":"section"},{"location":"documentation/#Documentation","page":"Documentation","title":"Documentation","text":"","category":"section"},{"location":"documentation/","page":"Documentation","title":"Documentation","text":"Using: Documenter.jl","category":"page"},{"location":"documentation/","page":"Documentation","title":"Documentation","text":"I'm interested to see how well we can document stuff, and I'm going to  mainly use the package documentation feature to document my findings during this exploration.\nSeems pretty good so far! I really like the freeformness of the documentation that we can link to docstrings and such. R's documentation system via  {roxygen2} is more restrictive and sometimes requires me to add a lot of  boilerplate. This one feels just right.\nOther packages have very scant package documentation. This is an opportunity to start contributing!","category":"page"},{"location":"orm/#Object-Relational-Mapping","page":"Object-Relational Mapping","title":"Object-Relational Mapping","text":"","category":"section"},{"location":"orm/","page":"Object-Relational Mapping","title":"Object-Relational Mapping","text":"Using: Stipple.jl, Octo.jl","category":"page"},{"location":"dataframes/#Data-Frames","page":"Data Frames","title":"Data Frames","text":"","category":"section"},{"location":"dataframes/","page":"Data Frames","title":"Data Frames","text":"I'm mainly coming at this from a Data Science and Backend systems point of view, so data frames are going to be hugely important.","category":"page"},{"location":"python/#Python-interoperability","page":"Python","title":"Python interoperability","text":"","category":"section"},{"location":"python/","page":"Python","title":"Python","text":"I want to be able ot manage environments and use packages in Python as binaries, not necessarily requiring such a deep integration.","category":"page"},{"location":"python/#Conda.jl","page":"Python","title":"Conda.jl","text":"","category":"section"},{"location":"#LearningJulia.jl","page":"Introduction","title":"LearningJulia.jl","text":"","category":"section"},{"location":"","page":"Introduction","title":"Introduction","text":"This package is just a container for all the code I write while trying to  learn the Julia language.","category":"page"},{"location":"","page":"Introduction","title":"Introduction","text":"I'm just writing bullet points and notes as a stream-of-consciousness, so  this won't be particularly organized, but hopefully this will help other R  users coming to Julia on what to watch out for and how well it might map to similar workflows.","category":"page"},{"location":"","page":"Introduction","title":"Introduction","text":"Depth = 1","category":"page"}]
}
