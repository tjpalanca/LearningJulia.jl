# Package Ecosystem

* I'm spoiled by CRAN. It's a pain to submit and maintain but it does result 
  in such a good user experience.
* Pkg is a great package manager with environments built in! What a relief 
  as python's venv, conda, etc was difficult to grok.
* I'm seeing that the Pkg registration process is quite liberal, so now I'm 
  struggling to find a way to easily gate the quality of packages and the 
  updated-ness of packages I want to use.

## Pkg.jl

* Designed around environments (independent sets of packages).
* Manifest file contains the exact versions of packages
* Dependency hell is managed because packages can have different dependency
  versions and use whatever is current at the time.
* You can modify a dependency by doing `develop --local Example` and then 
  go back to the standard version by doing `free Example`
* `add` a package to bring it from the registry to the environment
* `st` provides the current package and versions
* `add <github-repo>` or `add <local-path>` are also possible.
* `up Example` to update a package
* `test` package runs test suites
* `build` runs the package build process
* `gc` to prune / garbage-collect packages
* `activate <dir>` creates a package in the current directory
* `precompile` runs the precompilation scripts
* `instantiate` restores the package environment

### Creating packages

* `generate` creates a basic structure.
* `add` package dependencies. You can then `import` them into your own modules.
* `deps/build.jl` is the build script and then the results will be in 
  `deps/build.log`
* `test/runtests.jl` will be run for tests. this uses the `test/Project.toml`
  environment for test-specific dependencies.
* Package naming guidelines
  * Avoid jargon
  * Avoid using Julia or prefixing with Ju.
  * End with `.jl` to indicate that it's a Julia package
  * Pluralized names for the functionality they provide: `DataFrames.jl` for the 
    `DataFrame` type, etc.
  * Err on the side of clarity
  * Less systematic name may suit a package that is one implementation only
  * If you wrap a library then name it after that library.
  * Avoid naming it too closely to an existing package
* Use [`Registrator`](https://github.com/JuliaRegistries/Registrator.jl/) to 
  register packages. 

### Package compatibility 

* Add a `[compat]` section to the `Project.toml` to indicate compatibility with 
  specific version of packages and Julia.
  * Pre-0.1 versions are not compatible with each other.
  * Post-0.1 but Pre-1.0 versions are considered compatible for patch versions 
  * Caret Specifies allow upgrade up to the next major version
  * Tilde specificers allow upgrade up to the next minor version
  * Equality specifiers do not allow upgrades
  * Inequality specifiers allow unbounded inequality compatibility
  * Hyphen specifiers can be used to supply exact version ranges.

### Registries

* You can `registry add` to add a new registry. This is just a github repo
  with the pointers to the right packages.
* You can `registry rm` 
* You can `registry up` to update a registry.

### Artifacts

* immutable filesystem storage for anything that is not Julia.
* `Artifacts.toml` file which specifies tarfiles from a URL. 

+++
[<artifact-name>]
git-tree-sha = "Tar.tree_hash(IOBuffer(inflate_gzip(filename)))" # Git Tree Hash of the downloaded content

  [[<artifact-name.download>]]
  url = "<url-of-artifact>
  sha256 = "SHA.bytes2hex(open(sha256, filename))" # SHA of the download file
+++

* You can then refer to this folder with `artifact"<artifact_name>"`
* It's possible for artifacts to have no download stanza because it would be 
  filled in by code later.
* Artifacts are better than using the package directory because:
  * it makes package installation stateless
  * you can share artifacts between different package versions
