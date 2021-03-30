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
            "Databases" => "databases.md"
        ]
    ]
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
#=deploydocs(
    repo = "<repository url>"
)=#
