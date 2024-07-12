+++
title = "Visual Studio Code on HPC Clusters"
hascode = true
literate_mds = true
showall = false
noeval = true
+++

# Visual Studio Code on HPC Clusters

VS Code is a very popular IDE with a great [Julia extension](https://marketplace.visualstudio.com/items?itemName=julialang.language-julia) ([website](https://www.julia-vscode.org/)). Running it on a cluster typically isn't straightforward and we want to highlight the most important steps here.

---

\label{content}
**Content**

\toc

---

## What does "Running VS Code on a cluster" actually mean?

To be clear: What it **does not** mean is to have VS Code running locally and using its terminal (at the bottom) the `ssh` to the cluster and running `julia` on it.

Instead, we want to connect VS Code to a little server component that will run on the cluster. Hence, only the GUI will run locally and everything else will run on the cluster. This includes VS Code extensions, like the Julia extension and will eventually give us an integrated REPL, a debugger, a plot pane, etc., all working remotely on the cluster.

## Running VS Code on a login node (SSH)

**Note:** We assume that the hostname of the cluster is `mycluster`.

1) Make sure that you have password-less SSH access to the cluster (`ssh mycluster` should bring you to the cluster).

2) In VS Code, press `F1` and run the `Remote-SSH: Open SSH Host...` command.
   - If the command isn't available, make sure that [Remote - SSH extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh) is installed.
3) Enter `mycluster` and press enter.

After a second or two, you should have VS Code running on a login node! 🎉

[⤴ _**back to Content**_](#content)

## Installing the Julia extension

1) Open the extensions view (press `CTRL/CMD + SHIFT + X`).
2) Search for `julia`.
3) Click on `install`.

## Making the Julia extension work

Typically, the `julia` command is not directly available on a cluster but one must load a Julia module first (e.g. `module load julia`). Unfortunately, the Julia extension doesn't know about this, so we need to teach it.

1) Prepare a Julia wrapper script (`julia_wrapper.sh`) like the following:

```bash
#!/bin/bash

# Making module command available
# ------------------------------------------------------------
export MODULEPATH=/etc/modulefiles:/usr/share/modulefiles
export LMOD_SYSTEM_DEFAULT_MODULES="DefaultModules"
source /usr/share/lmod/lmod/init/profile
module --initial_load restore
# ------------------------------------------------------------

# Load julia
module load julia

# Pass on all arguments to julia
exec julia "${@}"
```

Note the module name as well as (at least) the first two lines of the block that makes the `module` command available are system specific and must be adjusted. To figure our the latter, you may run the following in a shell on the cluster: `echo $MODULEPATH` and `echo $LMOD_SYSTEM_DEFAULT_MODULES`.

2. Make the wrapper script executable: `chmod +x julia_wrapper.sh`

3. Check that it works: `./julia_wrapper.sh` should open the Julia REPL.

Once the wrapper is ready and functional, we need to point the Julia extension to it.

4. Open the VS Code Settings (press `CTRL/CMD + ,`).
5. Click on the tab `Remote [SSH: mycluster]`.
6. Search for `Julia executable`.
7. Insert `/path/to/julia_wrapper.sh` into the text field under `Julia: Executable Path`.

If `ALT/OPTION + J` followed by `ALT/OPTION + O` (**or** pressing `F1` and executing the `Julia: Start REPL` command) successfully spins up the integrated Julia REPL, you know that the setup is working! 🎉

**Important note:** If you want all the nice features of the Julia extension - like inline evaluation, plotting, debugging, etc. - you need to use the **integrated REPL** started by the shortcuts mentioned above. If you just type `julia` in a terminal (at the bottom), the resulting REPL will **not** be connected to the extension! 

[⤴ _**back to Content**_](#content)

## Can I run VS Code on a compute node? (SSH)

Maybe. The first thing you need to check is whether it is at all possible for you to connect to a compute node via SSH, as not all HPC centers allow this. (Note that typically you can only `ssh` to compute nodes that are part of a job that you have currently running.)

Given that you can `ssh` to compute nodes, what you want to do next is add a generic (wildcard) entry, that covers all compute nodes, to your `.ssh/config`. Assuming that the hostnames of the compute nodes start with `cn` (e.g. `cn1201` and `cn2134` etc.) and assuming that you already have a ssh config entry for `mycluster`, this could look like this:

```
Host cn*
    HostName %h
    ProxyJump mycluster
    User [USERNAME]
    IdentityFile [PATH TO PRIVATE KEY]
    IdentitiesOnly yes
```

Afterwards, you can use the following steps to run VS Code on a compute node:

1. Open a terminal (outside of VS Code)

2. Login to the cluster (`ssh mycluster`)

3. Get an interactive session on a compute node (and write down the name of the node that has been assigend to you, say, `cn1201`).

4. Follow the steps under [Running VS Code on a login node (SSH)](#running-vs-code-on-a-login-node-ssh) above but replace the hostname `mycluster` by the name of the compute node (e.g. `cn1201`).

[⤴ _**back to Content**_](#content)

## Running VS Code remotely via "remote tunnels"

Microsoft provides ["Remote tunnels"](https://code.visualstudio.com/docs/remote/tunnels) as an alternative to SSH to connect VS Code to remote systems.

**Pro**

* Allows you to connect to any machine with internet access (including cluster compute nodes that you can't ssh to!).

**Con**

* Requires a GitHub / Microsoft account.
* Microsoft serves as the tunnel provider (man in the middle).

1. Download the VS Code command line interface from [https://code.visualstudio.com/Download](https://code.visualstudio.com/Download) (search for **CLI**).

2. Copy the single `code` binary to the cluster (and put the directory on `PATH`).

3. Run `code tunnel --verbose` and follow the steps (to connect to your GitHub account).

4. Afterwards, open VS Code and install the [Remote - Tunnels](https://marketplace.visualstudio.com/items?itemName=ms-vscode.remote-server) extension.

5. Run the command `Remote-Tunnels: Connect to Tunnel...` and connect to the remote node.

[⤴ _**back to Content**_](#content)