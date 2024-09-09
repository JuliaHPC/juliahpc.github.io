+++
title = "Getting started"
hascode = true
literate_mds = true
showall = false
noeval = true
+++

# Getting started

Getting started with Julia on a new cluster can sometimes be a challenge. Below we provide some common tips that will hopefully help you with your onboarding process.

---

\label{content}
**Content**

\toc

---

## Use the regular Julia binaries or a Julia module (if available)

When starting on a new HPC cluster the first thing you should do is figure out if there is a pre-configured Julia module ([Lmod module](https://lmod.readthedocs.io/en/latest/010_user.html)) available on the cluster. To that end, `module key julia` or `module spider julia` might be helpful commands.

If there is no Julia module available that you can load, you should download and use the regular, precompiled Julia binaries. We strongly recommend to use [juliaup](https://github.com/JuliaLang/juliaup) for this. Alternatively, you can also manually download the binaries directly [from the website](https://julialang.org/downloads/). In any case, you should generally **not** build Julia from source (unless you have a very good reason).

Note that you **do not** need root privileges. Julia, and its packages, works great without special permissions in user space.

[⤴ _**back to Content**_](#content)

## Place the Julia depot on the parallel file system.

One you have Julia installed and you can run `julia` from the command line, you should place the Julia depot - the `.julia` folder where Julia stores all dependencies, logs, etc. - on an appropriate file system. By default, it will be stored in `$HOME/.julia`. This may or may not be a good choice, but more often than not it isn't.

You want to choose a file system with the following properties
* no tight quotas (at least >= 20 GB)
* read and write access (ideally also from compute nodes)
* good (parallel) I/O
* no automatic deletion of unused files (or otherwise you have to find a workaround)

**On most clusters these criterion are best fit on a parallel file system (often `$SCRATCH`).** In this case, you should put `JULIA_DEPOT_PATH=$SCRATCH/.julia` into your `.bashrc` (and your job scripts if `.bashrc` is not loaded by non-interactive jobs).

**Note:** If the last point (automatic deletion of unused files) is an issue for you, a pragmatic workaround could be a cronjob that touches all files in the Julia depot every once in a while.

[⤴ _**back to Content**_](#content)


## Set `JULIA_CPU_TARGET` appropriately.

On many clusters, the sections above are all you need to get a solid Julia setup. However, if you're on a **heterogeneous HPC cluster**, that is, if different nodes have different CPU (micro-)architectures, you should/need to do a few more preparations. Otherwise, you might encounter nasty error messages like "`Illegal instruction`".

To make Julia produce efficient code that works on different CPUs, you need to set [`JULIA_CPU_TARGET`](https://docs.julialang.org/en/v1.10-dev/manual/environment-variables/#JULIA_CPU_TARGET). For example, if you want Julia to compile all functions (`clone_all`) for Intel Skylake (`skylake-avx512`), AMD Zen 2 (`znver2`), and a generic fallback (`generic`), for safety, you could put the following into your `.bashrc` (also in your job script if the job includes precompilation, which is usually NOT recommended):

`export JULIA_CPU_TARGET="generic;skylake-avx512,clone_all;znver2,clone_all"`.

You can get the CPU target name for the current system with `Sys.CPU_NAME`. For more information, see [this section of the Julia documentation](https://docs.julialang.org/en/v1/manual/environment-variables/#JULIA_CPU_TARGET) and [this section of the developer documentation](https://docs.julialang.org/en/v1/devdocs/sysimg/#Specifying-multiple-system-image-targets).

[⤴ _**back to Content**_](#content)
