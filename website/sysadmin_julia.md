+++
title = "Admin: How to provide Julia to users?"
hascode = true
literate_mds = true
showall = false
noeval = true
+++

# Admin: How to provide Julia to users?

--- 

\label{content}
**Content**

\toc

---

## Providing Julia itself

It is generally best to just provide the regular, pre-built Julia binaries from [https://julialang.org/downloads/](https://julialang.org/downloads/). They work and are efficient.

You might be tempted to build Julia from source but this is almost never necessary or advantageous (and can be cumbersome). The reason is pretty simple: Julia is a compiler in itself and user code is therefore barely influenced by how you compiled Julia. Hence, unless you know exactly what you're doing and have a good reason in mind, the pre-built binaries are the way to go.

[⤴ _**back to Content**_](#content)

## Don't provide packages

We strongly recommend against trying to provide Julia packages (e.g. MPI.jl or CUDA.jl) in a central fashion. There are a few important technical reasons but the two most important reasons to **not** do it are conceptual

1) It conflicts with the idea of local, self-contained Julia environments.
2) Packages evolve too quickly (i.e. your central depot is out of date pretty quickly).

**Short explanation:** To have people use your centrally provided version of a package you would have to instruct them to not add that package to their (local) Julia environment as otherwise they'll very(!) likely get a different version of the package and will end up not using your central version to begin with. To make `using PackageX` still work, you would then have to adjust `JULIA_LOAD_PATH` appropriately. However, not only doesn't the user not get the version of `PackageX` that they potentially want/need, the local `Project.toml`/`Manifest.toml` would not even contain `PackageX` and therefore severely undermine self-containedness and reproducibility - one of the nicest properties of Julia projects.

Generally speaking, there is also little reason to provide regular Julia packages in a central fashion in the first place. After all, most of them don't take up that much disk space and a little bit of redundancy is acceptable on modern HPC clusters. In this regard, note that all packages only get installed **once per user** - and not per project as is the case for python - since Julia installs packages to a user-central depot and reuses them across projects.

[⤴ _**back to Content**_](#content)

## Providing global package preferences

What you might want to do is to globally override binary dependencies of Julia packages, so-called [Julia artifacts](https://pkgdocs.julialang.org/v1/artifacts/) ([JLLs](https://github.com/JuliaBinaryWrappers)), such that users automatically get redirected to system binaries under the hood. This is especially relevant if vendor specific binaries (e.g. a Cray MPI library) are the only ones that function properly on the HPC cluster. Below we describe how to realize this by overriding package [preferences](https://github.com/JuliaPackaging/Preferences.jl). However, note that JLLs have the big advantage that they are convenient and work nicely together. You should hence only override preferences if there is a good reason for it.


### Example: MPI.jl and CUDA.jl

In this example we show how to make MPI.jl automatically use a system OpenMPI installation as well as make CUDA.jl use a system CUDA installation. The two steps are pretty straightforward:

1) Create a global `Project.toml` that sets the preferences of the target packages.
2) Append the path to the global `Project.toml` to `JULIA_LOAD_PATH` (for all users).

According to the documentation of MPI.jl ([relevant section](https://juliaparallel.org/MPI.jl/stable/configuration/#Notes-to-HPC-cluster-administrators)) and CUDA.jl ([relevant section](https://cuda.juliagpu.org/stable/installation/overview/#Using-a-local-CUDA)) the preferences that we need to modify are actually not in MPI.jl or CUDA.jl but rather in MPIPreferences.jl and CUDA\_Runtime\_jll.jl. We thus create a `Project.toml` like below:

\note{Tip: To obtain the correct preferences blocks you can use `MPIPreferences.use_system_binary()` and `CUDA.set_runtime_version!(v"11.7"; local_toolkit=true)` respectively. This will create the relevant blocks in a `LocalPreferences.toml` file. The only thing you need to adjust is the block header, e.g. `MPIPreferences` -> `preferences.MPIPreferences`.}

```
[extras]
MPIPreferences = "3da0fdf6-3ccc-4f1b-acd9-58baa6c99267"
CUDA_Runtime_jll = "76a88914-d11a-5bdc-97e0-2f5a05c973a2"

[preferences.MPIPreferences]
_format = "1.0"
abi = "OpenMPI"
binary = "system"
libmpi = "libmpi"
mpiexec = "mpiexec"

[preferences.CUDA_Runtime_jll]
local = "true"
version = "11.7"
```

The only thing we then have to do is to append the path to this file to the `JULIA_LOAD_PATH`. The way to do it is as follows: `export JULIA_LOAD_PATH=:/path/to/projectoml/`. Note the critical colon (`:`) here which implies *appending* rather than overwriting.

### Providing everything in form of a Lmod module

Since every user should get the modified `JULIA_LOAD_PATH` above, the environment variable should best be set directly in the Lmod module that also provides the Julia binaries as well as the MPI and CUDA installations we're pointing to. This way, any user who loads the module and then adds MPI.jl and CUDA.jl to one of their environments (i.e. `] add MPI CUDA`) will automatically use the system MPI and system CUDA under the hood without having to do anything else. That is to say that the global preference system is *opt-out* (the user can always override the global preferences with local preferences, e.g. via a `LocalPreferences.toml`, on a per-project basis).

**Side note:** Speaking of setting environment variables in the module file, it is recommended to set `JULIA_CUDA_MEMORY_POOL=none` to disable the [memory pool](https://cuda.juliagpu.org/stable/usage/memory/#Memory-pool) that CUDA.jl uses by default. This is particularly advisable when you use a system CUDA due to incompatibility with certain CUDA APIs.

\note{You might want to check out [JuliaHPC_Installer](https://git.uni-paderborn.de/pc2-public/juliahpc_installer) which is a Julia script that automates the installation of a new Julia version via easybuild, including the global `Project.toml` setup discussed above. It is used on [Noctua 2](https://pc2.uni-paderborn.de/hpc-services/available-systems/noctua2) at [PC2](https://pc2.uni-paderborn.de/). However, it is currently not portable out of the box (since e.g. paths are hardcoded).}


### Checking that things work es expected
To check that things are working you can `] add MPI CUDA` and then run `CUDA.runtime_version()` and `CUDA.versioninfo()` which should give the version of the system CUDA and say "local installation", respectively:
```
julia> using CUDA

julia> CUDA.runtime_version()
v"11.7.0"

julia> CUDA.versioninfo()
CUDA runtime 11.7, local installation
CUDA driver 12.1
NVIDIA driver 530.30.2

[...]
```

Similarly, you can use `MPI.identify_implementation()` and `MPI.MPIPreferences.binary` which should show the version of the system MPI as well as "system", respectively:

```
julia> using MPI

julia> MPI.identify_implementation()
("OpenMPI", v"4.1.4")

julia> MPI.MPIPreferences.binary
"system"
```

[⤴ _**back to Content**_](#content)

## Supporting Visual Studio Code

One of the key features of Julia is that it is inherently dynamic. Users might thus likely want to use Julia interactively and remotely on your HPC cluster. One way to do so is through [VS Code](https://code.visualstudio.com/), specifically via the [Julia VS Code extension](https://www.julia-vscode.org/). The extension really only needs one thing to work: the `julia` binary. However, if you provide Julia as a module, this binary is only available if this module is already loaded (which it isn't if the user just connects to the cluster via [Remote - SSH](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh)).

A good solution to this problem is to provide a script (e.g. called `julia_vscode`), which serves as an in-place replacement for `julia` but takes care of the module loading first (see below).

```shell
#!/bin/bash
# Example script `julia_vscode` used on Noctua 2 at PC2
# The Julia module used below is called "lang/JuliaHPC"
# Author: Carsten Bauer

# ------ Set up the module system (HPC system specific) ------
export MODULEPATH=/etc/modulefiles:/usr/share/modulefiles || :
source /usr/share/lmod/lmod/init/profile
if [ -f "/opt/software/pc2/lmod/modules/DefaultModules.lua" ];then
        export MODULEPATH="$MODULEPATH:/opt/software/pc2/lmod/modules"
        export LMOD_SYSTEM_DEFAULT_MODULES="DefaultModules"
else
        if [ -f "/usr/share/modulefiles/StdEnv.lua" ];then
                export LMOD_SYSTEM_DEFAULT_MODULES="StdEnv"
        fi
fi
module --initial_load restore
# ------------------------------------------------------------

# Load a specific Julia module
module load lang/JuliaHPC/1.9.1-foss-2022a-CUDA-11.7.0

# Start Julia and pass on all command-line arguments
exec julia "${@}"
```

At PC2 such a script is provided for every Julia version / Julia module (see [JuliaHPC_Installer](https://git.uni-paderborn.de/pc2-public/juliahpc_installer)) as well as a generic one that only contains `module load lang/JuliaHPC` (without a version number) and thus always loads the latest Julia module.

[⤴ _**back to Content**_](#content)

## Potentially useful resources

* [JuliaHPC_Installer](https://git.uni-paderborn.de/pc2-public/juliahpc_installer) by [Carsten Bauer](https://carstenbauer.eu): a Julia script that automates the installation of a new Julia version via easybuild, including the global `Project.toml` setup discussed above. It is used on [Noctua 2](https://pc2.uni-paderborn.de/hpc-services/available-systems/noctua2) at [PC2](https://pc2.uni-paderborn.de/). However, it is currently not portable out of the box (since e.g. paths are hardcoded).
* [Johannes Blaschke](https://github.com/jblaschke) provides [scripts and templates](https://gitlab.blaschke.science/nersc/julia/-/tree/main/modulefiles) to set up modules file for Julia on some of NERSC's systems (warning: potentially outdated?)
* [Samuel Omlin](https://github.com/omlins) and colleagues from CSCS provide their [Easybuild configuration files](https://github.com/eth-cscs/production/tree/master/easybuild/easyconfigs/j/Julia) used for Piz Daint (warning: potentially outdated?)

[⤴ _**back to Content**_](#content)
