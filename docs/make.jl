using Documenter
using LearningJulia

makedocs(
    sitename = "LearningJulia",
    format = Documenter.HTML(),
    modules = [LearningJulia],
    pages = [
        "Introduction" => "index.md",
        "Learning Areas" => [
            "Development Environment" => "dev_env.md",
            "Databases" => "databases.md",
            "Documentation" => "documentation.md",
            "Data Frames" => "dataframes.md"
        ]
    ]
)

# deploydocs(
#     repo = "github.com/tjpalanca/LearningJulia.jl.git",
# )
