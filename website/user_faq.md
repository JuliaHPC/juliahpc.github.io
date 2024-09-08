+++
title = "FAQ"
hascode = true
literate_mds = true
showall = false
noeval = true
+++

# FAQ

\label{content}
**Content**

\toc

---

## Julia isn't available on my cluster. Can I install and use it (without root privileges)?

Yes, absolutely. You **do not** need root privileges to install Julia and its packages. However, often times it's better to put the Julia depot - the place where packages, artifacts, and other things will be stored - on the parallel file system rather than into `$HOME`. See the [Getting Started](/user_gettingstarted/) section for more information.

## Should I compile Julia from source?

**No, you should not.** Use the pre-built binaries from the website or, preferably, a corresponding Lmod module provided by the cluster admins. Compiling Julia from source will generally **not** improve the performance of your code (Julia is a compiler in itself) but may very well be cumbersome. Unless you know what you're doing and have a very good reason (e.g. creating a debug build with flags like `USE_INTEL_JITEVENTS=1`) you should not compile Julia yourself.

[⤴ _**back to Content**_](#content)

## Where should I put the Julia depot?

Ideally, you should set `JULIA_DEPOT_PATH` to point to a place with the following properties:

* good (parallel) I/O
* no tight quotas
* read and write access
* no automatic deletion of unused files (or otherwise you have to find a workaround)

As a rule of thumb: Put the Julia depot on the parallel file system (typically `$SCRATCH`).

[⤴ _**back to Content**_](#content)

## How should I start Julia within a job script?

Assuming that SLURM is used on your HPC cluster, you should generally start Julia under `srun`, e.g. `srun julia --project mycode.jl`. This is especially important if your code is MPI-parallel, in which case `srun` is a replacement for `mpirun`/`mpiexec`, but also recommended for serial code (there are at least [a few reasons](https://stackoverflow.com/a/53640511/2365675)).

Note that you can use the slim `mpiexecjl` wrapper from `MPI.jl` to use the "correct" MPI driver automatically.

[⤴ _**back to Content**_](#content)

## How can I force Julia to compile code for a heterogeneous cluster?

Set [`JULIA_CPU_TARGET`](https://docs.julialang.org/en/v1.10-dev/manual/environment-variables/#JULIA_CPU_TARGET) to a value that is generic enough to cover all the types of CPUs that you're targeting. You can get the CPU target name for the current system with `Sys.CPU_NAME`.

**Example:** `JULIA_CPU_TARGET="generic;skylake-avx512,clone_all;znver2,clone_all"`.

This compiles all functions (`clone_all`) for Intel Skylake (`skylake-avx512`), AMD Zen 2 (`znver2`), and a generic fallback (`generic`).

For more information, see [this section of the Julia documentation](https://docs.julialang.org/en/v1/manual/environment-variables/#JULIA_CPU_TARGET) and [this section of the developer documentation](https://docs.julialang.org/en/v1/devdocs/sysimg/#Specifying-multiple-system-image-targets).

[⤴ _**back to Content**_](#content)

## Should I use Distributed.jl or MPI.jl for large-scale parallelism?

While the Distributed standard library provides some convenient tools and has its use cases you should generally use MPI.jl to scale your code up (e.g. to thousands of compute nodes). Not only is MPI the established standard for distributed computing in any programming language, it also makes use of fast interconnects in HPC clusters (which the Distributed standard library currently doesn't).

[⤴ _**back to Content**_](#content)

## Should I use Julia artifacts (JLLs) or system software?

If JLLs work fine for you then use them. JLLs have the big advantage that they are convenient and, in many cases, "just work" out of the box. System software can (but doesn't necessarily) give better performance but overriding the relevant bits of JLLs can be cumbersome. Generally speaking, we recommend to only manually replace JLL libraries by system software if JLLs don't work (e.g. if a vendor specific MPI is required). However, in such a case it would be even better to nudge the HPC admins and make this setup permanent and generally available in form of a Julia Lmod module.

[⤴ _**back to Content**_](#content)

## How to cope with a large number of MPI processes accessing the same Julia depot?

In a distributed computing scenario with, e.g., multiple thousands of Julia (MPI) processes, accessing the same Julia depot on a shared file system - when loading packages and precompiled cache files on `using PackageX` - can become (very) time consuming. A workaround is to bundle up the Julia depot (e.g. as a `.tar.gz`), distribute it to the local node storage (if available) or local memory (often times mounted as `/tmp`) of all assigned compute nodes, and then set the `JULIA_DEPOT_PATH` accordingly.

[⤴ _**back to Content**_](#content)


## How to avoid `LD_LIBRARY_PATH` issues?

When using Julia on a system that uses an environment-variable based module
system (such as [modules](https://github.com/cea-hpc/modules) or
[Lmod](https://github.com/TACC/Lmod)), the `LD_LIBRARY_PATH` variable might
be filled with entries pointing to different packages and libraries. This might (or might not) lead to
issues stemming from Julia loading libraries other than the ones packaged with
it. If you encounter such problems, make sure that Julia's `lib` directory is always the *first* directory in
`LD_LIBRARY_PATH`.

One possibility to achieve this is to create a wrapper shell script that
modifies `LD_LIBRARY_PATH` before calling the Julia executable. Inspired by a
[script](https://github.com/UCL-RITS/rcps-buildscripts/blob/04b2e2ccfe7e195fd0396b572e9f8ff426b37f0e/files/julia/julia.sh)
from UCL's [Owain Kenway](https://github.com/owainkenwayucl):
```shell
#!/usr/bin/env bash

# This wrapper makes sure the julia binary distributions picks up the GCC
# libraries provided with it correctly meaning that it does not rely on
# the gcc-libs version.

# Dr Owain Kenway, 20th of July, 2021
# Source: https://github.com/UCL-RITS/rcps-buildscripts/blob/04b2e2ccfe7e195fd0396b572e9f8ff426b37f0e/files/julia/julia.sh

location=$(readlink -f $0)
directory=$(readlink -f $(dirname ${location})/..)

export LD_LIBRARY_PATH=${directory}/lib/julia:${LD_LIBRARY_PATH}
exec ${directory}/bin/julia "$@"
```

Note that using `readlink` might not be optimal from a performance perspective
if used in a massively parallel environment. Alternatively, hard-code the Julia
path or set an environment variable accordingly.

[⤴ _**back to Content**_](#content)

## I get memory-related issues when using CUDA.jl on a HPC cluster

Try setting `JULIA_CUDA_MEMORY_POOL=none` (see the [CUDA.jl documentation](https://cuda.juliagpu.org/stable/usage/memory/#Memory-pool) for more information).

[⤴ _**back to Content**_](#content)

## Precompilation on a login node fails (`Resource temporarily unavailable`)

By default, Julia uses many parallel tasks during precompilation. On the login nodes of some HPC clusters, parallel processes might be subject to resource restrictions. In these cases, you might want to set [`JULIA_NUM_PRECOMPILE_TASKS`](https://docs.julialang.org/en/v1/manual/environment-variables/#JULIA_NUM_PRECOMPILE_TASKS) to a low value, e.g. `export JULIA_NUM_PRECOMPILE_TASKS=1` (single task).

[⤴ _**back to Content**_](#content)

## Julia crashes on startup on a login node

Related to the previous question, if the login node forbids using more than a certain number of threads, it could cause Julia's dependent `C`/`C++` libraries to fail to load. In these cases, you might want to set [`OMP_NUM_THREADS`](https://www.openmp.org/spec-html/5.0/openmpse50.html) to a low value, e.g. `export OMP_NUM_THREADS=1`.

[⤴ _**back to Content**_](#content)

## Can I precompile GPU code on a login node without a GPU?

Yes, at least for CUDA.jl. See [this part](https://cuda.juliagpu.org/stable/installation/overview/#Precompiling-CUDA.jl-without-CUDA) of the CUDA.jl documentation.

[⤴ _**back to Content**_](#content)
