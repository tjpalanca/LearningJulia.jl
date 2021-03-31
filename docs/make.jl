using Documenter
using LearningJulia

makedocs(
    sitename = "LearningJulia",
    format = Documenter.HTML(),
    modules = [LearningJulia],
    pages = [
        "Introduction" => "index.md",
        "General" => [
            "Ecosystem" => "ecosystem.md",
            "Language" => "language.md",
            "Development Environment" => "dev_env.md",
            "Documentation" => "documentation.md",
        ],
        "Software Development" => [
            "Databases" => "databases.md",
            "Object-Relational Mapping" => "orm.md"
        ],
        "Data Science" => [
            "Data Frames" => "dataframes.md",
        ],
        "Interoperability" => [
            "Python" => "python.md"
        ]
    ]
)

deploydocs(
    repo = "github.com/tjpalanca/LearningJulia.jl.git",
)
