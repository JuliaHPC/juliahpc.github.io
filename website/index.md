+++
title = "Julia On HPC Clusters"
+++

# Julia on HPC clusters

👋 Welcome to the notes about the [Julia programming language](http://www.julialang.org/) on HPC clusters.

## Objective
The goal of these notes is to offer good practices and tips and tricks about how to use and set up Julia on HPC clusters. The target audiences are therefore Julia users on clusters as well as HPC system administrators.

## Acknowledgements

These notes don't come out of nowhere but stem from endless conversations with many people (see below for a certainly incomplete list) on the Julia discourse, over Slack and Discord, as well as in-person discussions at Julia HPC minisymposia, BoFs, and workshops.

They also build upon previous efforts to document best practices, most notably [https://github.com/hlrs-tasc/julia-on-hpc-systems/](https://github.com/hlrs-tasc/julia-on-hpc-systems/), from which we took (among other things) the [HPC systems with Julia support](/user_hpcsystems/) information.

### People

#### Maintainers
- [Carsten Bauer](https://carstenbauer.eu/) - [PC2](https://pc2.uni-paderborn.de/) / [NHR](https://www.nhr-verein.de/) (creator)
<!-- - [Michael Schlottke-Lakemper](https://lakemper.eu/) - [RWTH](https://www.rwth-aachen.de/go/id/a/?lidx=1) / [HLRS](https://www.hlrs.de/) -->

#### Contributors

The following people have provided valuable contributions, either in the form of
PRs or via public or private communication:
* Alexander Bills ([@abillscmu](https://github.com/abillscmu))
* Johannes Blaschke ([@jblaschke](https://github.com/jblaschke)) - NERSC
* Valentin Churavy ([@vchuravy](https://github.com/vchuravy)) - MIT
* Steffen Fürst ([@s-fuerst](https://github.com/s-fuerst))
* Mosè Giordano ([@giordano](https://github.com/giordano)) - UCL
* William Godoy ([@williamfgc](https://github.com/williamfgc)) - ORNL
* C. Brenhin Keller ([@brenhinkeller](https://github.com/brenhinkeller))
* Mirek Kratochvíl ([@exaexa](https://github.com/exaexa))
* Pedro Ojeda ([@pojeda](https://github.com/pojeda))
* Samuel Omlin ([@omlins](https://github.com/omlins)) - CSCS / ETHZ
* Ludovic Räss ([@luraess](https://github.com/luraess)) - ETHZ
* Michael Schlottke-Lakemper ([@sloede](https://github.com/sloede)) - HLRS / RWTH
* Erik Schnetter ([@eschnett](https://github.com/eschnett)) - PITP
* Dinindu Senanayake ([@DininduSenanayake](https://github.com/DininduSenanayake))
* Kjartan Thor Wikfeldt ([@wikfeldt](https://github.com/wikfeldt)) - ENCCS

(You think we forgot your name here? Please make a PR!)