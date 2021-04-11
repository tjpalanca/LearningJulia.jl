using Documenter
using LearningJulia

makedocs(
    sitename = "LearningJulia",
    format = Documenter.HTML(),
    modules = [LearningJulia],
    pages = [
        "Introduction" => "index.md",
        "General" => [
            "Language" => "language.md",
            "Packages" => "packages.md",
            "Development Environment" => "dev_env.md",
            "Documentation" => "documentation.md",
        ],
        "Software Development" => [
            "Databases" => "databases.md",
            "Object-Relational Mapping" => "orm.md",
            "Web Development" => "web.md"
        ],
        "Data Science" => [
            "Data Frames" => "dataframes.md",
            "Computation" => "computation.md",
            "Visualization" => "visualization.md",
            "Reinforcement Learning" => "reinforcement.md"
        ],
        "Interoperability" => [
            "Python" => "python.md"
        ],
        "Applications" => [
            "Smart Home" => "smart_home.md",
            "Blogging" => "blogging.md",
            "Generative Art" => "generative.md"
        ],
        "Miscellaneous" => "misc.md"
    ]
)

!isinteractive() && deploydocs(
    repo = "github.com/tjpalanca/LearningJulia.jl.git",
)  
