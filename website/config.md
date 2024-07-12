<!--
Add here global page variables to use throughout your website.
The website_* must be defined for the RSS to work
-->
@def website_title = "Julia On HPC Clusters"
@def website_descr = "Learn how to use and/or set up Julia on HPC clusters"
@def website_url   = "https://juliahpc.github.io/"

@def author = "Carsten Bauer"

@def mintoclevel = 2
@def maxtoclevel = 3

@def prepath = "JuliaOnHPCClusters"
<!--
Add here files or directories that should be ignored by Franklin, otherwise
these files might be copied and, if markdown, processed by Franklin which
you might not want. Indicate directories by ending the name with a `/`.
-->
@def ignore = ["node_modules/", "franklin", "franklin.pub"]

<!--
Add here global latex commands to use throughout your
pages. It can be math commands but does not need to be.
For instance:
* \newcommand{\phrase}{This is a long phrase to copy.}
-->
\newcommand{\R}{\mathbb R}
\newcommand{\scal}[1]{\langle #1 \rangle}

\newcommand{\note}[1]{@@note @@title :bulb: Note@@ @@messg #1 @@ @@}
\newcommand{\warn}[1]{@@warning @@title ⚠️ Warning!@@ @@messg #1 @@ @@}
