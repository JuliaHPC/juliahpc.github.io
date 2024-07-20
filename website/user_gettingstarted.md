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

## Julia binaries or Julia module

When starting on a new HPC cluster the first thing you should do is figure out if there is a pre-configured Julia module ([Lmod module](https://lmod.readthedocs.io/en/latest/010_user.html)) available on the cluster. To that end, `module key julia` or `module spider julia` might be helpful commands.

If there isn't a Julia module available that you can load, you should use the regular, pre-built Julia binaries. You can either download (e.g. `wget` or `curl`) them directly [from the website](https://julialang.org/downloads/) or use [juliaup](https://github.com/JuliaLang/juliaup). In any case, you should **not** build Julia from source (unless you have a very good reason and know that you're doing).

[⤴ _**back to Content**_](#content)

## Placing the Julia depot

One you have `julia`, you must make sure that the Julia depot is placed on an appropriate file system. By default, it will be stored in `$HOME/.julia`. This may or may not be a good choice. What you want is a place on a file system with the following properties
* no tight quotas (at least >= 20 GB)
* read and write access (ideally also from compute nodes)
* good (parallel) I/O
* no automatic deletion of unused files (or otherwise you have to find a workaround)

Often times these criterion are best fit on a parallel file system (often `$SCRATCH`). For this reason it might be necessary to set `JULIA_DEPOT_PATH=$SCRATCH/.julia`.

Note that if the last point (automatic deletion of unused files) is an issue for you, a pragmatic workaround could be a cronjob that touches all files in the Julia depot every once in a while.

[⤴ _**back to Content**_](#content)
