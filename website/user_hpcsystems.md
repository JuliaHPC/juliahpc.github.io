+++
title = "HPC systems with Julia support"
hascode = true
literate_mds = true
showall = false
noeval = true
+++

# HPC systems with Julia support

\note{It is difficult to keep the table below up-to-date. It is also almost certainly incomplete. We rely on people like you, so please [update the table](https://github.com/JuliaHPC/juliahpc.github.io/edit/main/website/user_hpcsystems.md) if you think something can be improved!}

---

\label{content}
**Content**

\toc

---

## Description
We try to maintain an (incomplete) list of HPC systems that provide a
Julia installation and/or support for using Julia to its users. For this, we use the following nomenclature:
* *Center:* The HPC center's name
* *System:* The compute system's "marketing" name
* *Installation:* Is a pre-installed Julia module available?
* *Support:* Can users expect "official" Julia support on the system (e.g. by HPC staff)?
* *Interactive:* Is interactive computing with Julia supported, i.e., can you run parallel jobs on the system interactively via, e.g., Jupyter notebooks?
* *Architecture:* The main CPU used in the system
* *Accelerators:* The main accelerator (if anything) in the system
* *Documentation:* Links to documentation for Julia users

## HPC systems

(Sorted in alphabetical order)

### Australasia
**Center** | **System** | **Installation** | **Support** | **Interactive** | **Architecture** | **Accelerators** | **Documentation**
-----|-----|-----|-----|-----|-----|-----|-----
[NeSI](https://www.nesi.org.nz/) | [Mahuika, Māui](https://www.nesi.org.nz/services/high-performance-computing-and-analytics/platforms) | ✅ | ✅ | ✅ | [Intel Xeon Broadwell/Cascade Lake + AMD EPYC Milan](https://www.nesi.org.nz/services/high-performance-computing-and-analytics/platforms) | [Nvidia Tesla P100, A100](https://support.nesi.org.nz/hc/en-gb/articles/360001471955) | [1](https://support.nesi.org.nz/hc/en-gb/articles/360001175895-Julia)

### Europe
**Center** | **System** | **Installation** | **Support** | **Interactive** | **Architecture** | **Accelerators** | **Documentation**
-----|-----|-----|-----|-----|-----|-----|-----
[ARC, UCL](https://www.ucl.ac.uk/arc) | [Myriad](https://www.rc.ucl.ac.uk/docs/Clusters/Myriad/), [Kathleen](https://www.rc.ucl.ac.uk/docs/Clusters/Kathleen/), [Michael](https://www.rc.ucl.ac.uk/docs/Clusters/Michael/), [Young](https://www.rc.ucl.ac.uk/docs/Clusters/Young/) | ✅ | ✅ | ? | various Intel Xeon | various GPUs | [1](https://www.rc.ucl.ac.uk/docs/)
[CSC](https://csc.fi/) (EuroHPC) | [LUMI](https://www.lumi-supercomputer.eu/) | ✅ | ✅ | ✅ | [AMD EPYC Milan](https://docs.lumi-supercomputer.eu/generic/overview/) | [AMD Radeon Instinct MI250X](https://www.lumi-supercomputer.eu/lumis-full-system-architecture-revealed/) | [1](https://docs.csc.fi/apps/julia/), [2](https://docs.csc.fi/support/tutorials/julia/)
[CSC](https://csc.fi/) | [Puhti](https://docs.csc.fi/computing/systems-puhti/) | ✅ | ✅ | ✅ | Intel Xeon Gold 6230 | Nvidia Tesla V100 | [1](https://docs.csc.fi/apps/julia/), [2](https://docs.csc.fi/support/tutorials/julia/)
[CSC](https://csc.fi/) | [Mahti](https://docs.csc.fi/computing/systems-mahti/) | ✅ | ✅ | ✅ | AMD EPYC 7H12 | Nvidia Ampere A100 | [1](https://docs.csc.fi/apps/julia/), [2](https://docs.csc.fi/support/tutorials/julia/)
[CSCS](https://www.cscs.ch) | [Piz Daint](https://www.cscs.ch/computers/piz-daint/) | ✅ | ✅ | ✅ | [Intel Xeon Broadwell + Haswell](https://www.cscs.ch/computers/piz-daint/) | [Nvidia Tesla P100](https://www.cscs.ch/computers/piz-daint/) | [1](https://user.cscs.ch/tools/interactive/julia/)
[DESY IT](https://it.desy.de) | [Maxwell](https://docs.desy.de/maxwell/) | ✅ | ? | ✅ | [various AMD EPYC/Intel Xeon](https://docs.desy.de/maxwell/infrastructure/compute/) | [various GPUs](https://docs.desy.de/maxwell/infrastructure/compute/hw_allgpu/) | [1](https://docs.desy.de/maxwell/development/julia/)
[HLRS](https://www.hlrs.de) | [Hawk](https://www.hlrs.de/systems/hpe-apollo-hawk/) | ✅ | ✅ | ✅ | [AMD EPYC Rome](https://www.hlrs.de/systems/hpe-apollo-hawk/) | [Nvidia Tesla A100](https://www.hlrs.de/systems/hpe-apollo-hawk/) | [1](https://kb.hlrs.de/platforms/index.php/Julia)
[HPC2N, Umeå U](https://www.hpc2n.umu.se/) | [Kebnekaise](https://www.hpc2n.umu.se/resources/hardware/kebnekaise) | ✅ | ✅ | ? | [Intel Xeon Broadwell + Skylake](https://www.hpc2n.umu.se/resources/hardware/kebnekaise) | [Nvidia Tesla K80](https://www.hpc2n.umu.se/resources/hardware/kebnekaise), [Nvidia Tesla V100](https://www.hpc2n.umu.se/resources/hardware/kebnekaise) | [1](https://www.hpc2n.umu.se/resources/software/julia)
[IT4I](https://www.it4i.cz/) (EuroHPC) | [Karolina](https://www.it4i.cz/infrastruktura/karolina) | ✅ | ✅ | ✅ | [AMD EPYC Rome](https://www.it4i.cz/en/infrastructure/karolina) | [Nvidia Ampere A100](https://www.it4i.cz/en/infrastructure/karolina) | [1](https://docs.it4i.cz/software/lang/julialang/)
[IZUM](https://www.izum.si/en/home/) (EuroHPC) | [Vega](https://www.izum.si/en/hpc-en/) | ✅ | ✅ | ✅ | [AMD EPYC Rome](https://www.izum.si/en/vega-en/) | [Nvidia Ampere A100](https://www.izum.si/en/vega-en/) | [1](https://doc.vega.izum.si/)
[LuxProvide](https://luxprovide.lu/) (EuroHPC) | [MeluXina](https://luxprovide.lu/#meluxina) | ✅ | ? | ✅ | [AMD EPYC Rome](https://docs.lxp.lu/system/overview/) | [Nvidia Ampere A100-40](https://docs.lxp.lu/system/overview/) | [1](https://docs.lxp.lu/software/module_example/julia/), [2](https://docs.lxp.lu/first-steps/software_env/)
[PC2, U Paderborn](https://pc2.uni-paderborn.de/) | [Noctua 1](https://pc2.uni-paderborn.de/hpc-services/available-systems/noctua1) | ✅ | ✅ | ✅ | [Intel Xeon Skylake](https://pc2.uni-paderborn.de/hpc-services/available-systems/noctua1) | [Intel Stratix 10](https://pc2.uni-paderborn.de/hpc-services/available-systems/noctua1) + consumer GPUs | [1](https://upb-pc2.atlassian.net/wiki/spaces/PC2DOK/pages/1902093/Julia)
[PC2, U Paderborn](https://pc2.uni-paderborn.de/) | [Noctua 2](https://pc2.uni-paderborn.de/hpc-services/available-systems/noctua2) | ✅ | ✅ | ✅ | [AMD EPYC Milan](https://pc2.uni-paderborn.de/hpc-services/available-systems/noctua2) | [Nvidia Ampere A100](https://pc2.uni-paderborn.de/hpc-services/available-systems/noctua2), [Xilinx Alveo U280](https://pc2.uni-paderborn.de/hpc-services/available-systems/noctua2) | [1](https://upb-pc2.atlassian.net/wiki/spaces/PC2DOK/pages/1902093/Julia)
[ULHPC, U Luxembourg](https://hpc.uni.lu/) | [Aion](https://hpc-docs.uni.lu/systems/aion/), [Iris](https://hpc-docs.uni.lu/systems/iris/) | ✅ | ? | ✅ | [AMD EPYC Rome](https://hpc-docs.uni.lu/systems/aion/) + [Intel Xeon Broadwell/Skylake](https://hpc-docs.uni.lu/systems/iris/) | [Nvidia Tesla V100](https://hpc-docs.uni.lu/systems/iris/) | [1](https://hpc-docs.uni.lu/software/maths/julia/)
[ZDV, U Mainz](https://hpc-en.uni-mainz.de/) | [MOGON II](https://hpc-en.uni-mainz.de/high-performance-computing/systeme/) | ✅ | ? | ? | [Intel Xeon Broadwell + Skylake](https://hpc-en.uni-mainz.de/high-performance-computing/systeme/) | no | [1](https://mogonwiki.zdv.uni-mainz.de/dokuwiki/start:development:scripting_languages:julia)
[ZIB](https://www.zib.de/) | [HLRN-IV](https://www.hlrn.de/supercomputer-e/hlrn-iv-system/?lang=en) | ✅ | ✅ | ? | [Intel Cascade Lake AP]((https://www.hlrn.de/supercomputer-e/hlrn-iv-system/?lang=en)) |[Nvidia Ampere A100](https://www.izum.si/en/vega-en/) (but there is no Julia module available on those nodes) | [1](https://user.nhr.zib.de/wiki/spaces/PUB/pages/429360/Julia)

### North America

**Center** | **System** | **Installation** | **Support** | **Interactive** | **Architecture** | **Accelerators** | **Documentation**
-----|-----|-----|-----|-----|-----|-----|-----
[Carnegie Mellon College of Engineering](https://engineering.cmu.edu) | [Arjuna](https://arjunacluster.github.io/ArjunaUsers/), Hercules | ✅ | ✅  | ✅  | Intel Xeon+AMD EPYC Milan | Nvidia A100, Nvidia K80 | [1](https://arjunacluster.github.io/ArjunaUsers/)
[Dartmouth College](https://dartmouth.edu) | [Discovery](https://rc.dartmouth.edu/index.php/discovery-overview/) | ✅ | ? | ✅  | [Intel Xeon (various) + AMD EPYC 7532](https://services.dartmouth.edu/TDClient/1806/Portal/KB/ArticleDet?ID=134058) | [Nvidia V100](https://services.dartmouth.edu/TDClient/1806/Portal/KB/ArticleDet?ID=133133) | [1](https://rc.dartmouth.edu/index.php/discovery-overview/)
[FASRC, Harvard U](https://www.rc.fas.harvard.edu) | [Cannon](https://www.rc.fas.harvard.edu/about/cluster-architecture/) | ✅ | ? | ✅ | [Intel Xeon Cascade Lake](https://www.rc.fas.harvard.edu/about/cluster-architecture/) | [Nvidia V100, A100](https://www.rc.fas.harvard.edu/about/cluster-architecture/) | [1](https://portal.rc.fas.harvard.edu/p3/build-reports/julia)
[HPC @ LLNL](https://hpc.llnl.gov/) | various systems | ✅ | ? | ✅ | various processors | various GPUs | [1](https://hpc.llnl.gov/services/jupyter/julia)
[NERSC](https://www.nersc.gov) | [Cori](https://www.nersc.gov/systems/cori/) | ✅ | ? | ? | [Intel Xeon Haswell](https://docs.nersc.gov/systems/cori/#system-specification) | [Intel Xeon Phi](https://docs.nersc.gov/systems/cori/#system-specification) | [1](https://docs.nersc.gov/development/languages/julia/)
[NERSC](https://www.nersc.gov) | [Perlmutter](https://www.nersc.gov/systems/perlmutter/) | ✅ | ✅ | ? | [AMD EPYC Milan](https://docs.nersc.gov/systems/perlmutter/system_details/#cpus) | [Nvidia Ampere A100](https://docs.nersc.gov/systems/perlmutter/system_details/#gpus) | [1](https://docs.nersc.gov/development/languages/julia/), [2](https://docs.nersc.gov/performance/readiness/#julia)
[Open Science Grid](https://opensciencegrid.org) | N/A | ❌ | ✅  | ?  | [Various](https://support.opensciencegrid.org/support/solutions/articles/5000632058-computation-on-the-open-science-pool) | [Various](https://support.opensciencegrid.org/support/solutions/articles/5000653025-using-gpus-on-the-ospool) | [1](https://support.opensciencegrid.org/support/solutions/articles/12000078187-using-julia-on-the-ospool)
[Perimeter Institute for Theoretical Physics](https://perimeterinstitute.ca) | Symmetry | ✅ | ✅  | ✅ | AMD EPYC, Intel Xeon | Nvidia V100 | -
[Pittsburgh Supercomputing Center](https://www.psc.edu) | [Bridges-2](https://www.psc.edu/resources/bridges-2/) | ✅ | ✅  | ✅ | [AMD EPYC, Intel Xeon](https://www.psc.edu/resources/bridges-2/) | [Nvidia V100](https://www.psc.edu/resources/bridges-2/) | [1](https://www.psc.edu/resources/software/julia/)
[Princeton University](https://princeton.edu) | Several including [Tiger](https://researchcomputing.princeton.edu/systems/tiger) | ✅ | ✅ | ✅  | [Intel Xeon (Skylake + Broadwell)](https://researchcomputing.princeton.edu/systems/tiger) | [Nvidia P100](https://researchcomputing.princeton.edu/systems/tiger) | [1](https://researchcomputing.princeton.edu/support/knowledge-base/julia)

### Other HPC systems
There are a number of other HPC systems that have been reported to provide a Julia installation and/or Julia support, but lack enough details to be put on the list above:

* Various clusters at [ANL](https://www.anl.gov)
