# Trying artifacts

using Pkg.Artifacts
using CSV
using DataFrames

artifact_toml = joinpath(pwd(), "Artifacts.toml")

iris_hash = artifact_hash("iris", artifact_toml)

if iris_hash === nothing || !artifact_exists(iris_hash)
    iris_hash = create_artifact() do artifact_dir
        iris_url_base = "https://archive.ics.uci.edu/ml/machine-learning-databases/iris"
        download("$(iris_url_base)/iris.data", joinpath(artifact_dir, "iris.csv"))
        download("$(iris_url_base)/bezdekIris.data", joinpath(artifact_dir, "bezdekIris.csv"))
        download("$(iris_url_base)/iris.names", joinpath(artifact_dir, "iris.names"))
    end
    bind_artifact!(artifact_toml, "iris", iris_hash)
end

iris_dataset_path = artifact_path(iris_hash)

CSV.read(joinpath(artifact"iris", "iris.csv"), DataFrame)