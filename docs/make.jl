import Documenter
import MultiDocumenter

clonedir = joinpath(@__DIR__, "clones")
deploying = "deploy" in ARGS

# Build local docs
Documenter.makedocs(
    sitename = "JuliaHPC",
    pages = [
        "index.md",
        "For Users" => [
            "user_gettingstarted.md",
            "user_vscode.md",
            "user_hpcprofiling/index.md",
            "user_hpcsystems.md",
            "user_faq.md"
        ],
        "For System Admins" => [
            "sysadmin_julia.md"
        ]
    ],
    format = Documenter.HTML(assets = ["assets/favicon.ico"])
)

# Helper function stolen from DynamicalSystemsDocs.jl
function multidocref(package, descr = "")
    name = "$(package).jl"

    MultiDocumenter.MultiDocRef(;
        upstream = joinpath(clonedir, package),
        path = lowercase(package),
        name = isempty(descr) ? "$(name)" : "$(name) - $(descr)",
        giturl = "https://github.com/JuliaParallel/$(name).git",
    )
end

link(package) = MultiDocumenter.Link("$(package).jl", "https://github.com/JuliaParallel/$(package).jl")

docs = [
    MultiDocumenter.MultiDocRef(
        upstream = joinpath(@__DIR__, "build"),
        path = "Overview",
        name = "Home",
        fix_canonical_url = false,),
    MultiDocumenter.DropdownNav("HPC packages", [
        multidocref("MPI", "Julia bindings to MPI"),
        multidocref("Dagger", "DAG-based computing"),
        MultiDocumenter.MultiDocRef(;
           upstream = joinpath(clonedir, "ParallelProcessingTools"),
           path = "parallelprocessingtools",
           name = "ParallelProcessingTools.jl - Utilities for doing parallel/distributed computing",
           giturl = "https://github.com/oschulz/ParallelProcessingTools.jl.git")
    ]),
    MultiDocumenter.MegaDropdownNav("Distributed packages", [
        MultiDocumenter.Column("Implementations", [
            MultiDocumenter.Link("Distributed.jl - Stdlib for distributed computing", "https://docs.julialang.org/en/v1/stdlib/Distributed/"),
            multidocref("DistributedNext", "Bleeding-edge fork of Distributed.jl")           
        ]),
        MultiDocumenter.Column("Cluster managers", [
            link("SlurmClusterManager"),
            link("MPIClusterManagers"),
            link("ElasticClusterManager"),
            link("LSFClusterManager")
        ])
    ])
]

outpath = deploying ? mktempdir() : joinpath(@__DIR__, "build")

MultiDocumenter.make(
    outpath,
    docs;
    search_engine = MultiDocumenter.SearchConfig(
        index_versions = ["stable"],
        engine = MultiDocumenter.FlexSearch
    ),
    assets_dir = "docs/src/assets",
    brand_image = MultiDocumenter.BrandImage("https://juliahpc.github.io", "assets/logo.png")
)

if "deploy" in ARGS
    @info "Deploying to GitHub" ARGS
    gitroot = normpath(joinpath(@__DIR__, ".."))
    run(`git pull`)
    outbranch = "gh-pages"
    has_outbranch = true
    if !success(`git checkout $outbranch`)
        has_outbranch = false
        if !success(`git switch --orphan $outbranch`)
            @error "Cannot create new orphaned branch $outbranch."
            exit(1)
        end
    end
    for file in readdir(gitroot; join = true)
        endswith(file, ".git") && continue
        rm(file; force = true, recursive = true)
    end
    for file in readdir(outpath)
        cp(joinpath(outpath, file), joinpath(gitroot, file))
    end
    run(`git add .`)
    if success(`git commit -m 'Aggregate documentation'`)
        @info "Pushing updated documentation."
        if has_outbranch
            run(`git push`)
        else
            run(`git push -u origin $outbranch`)
        end
        run(`git checkout master`)
    else
        @info "No changes to aggregated documentation."
    end
else
    @info "Skipping deployment, 'deploy' not passed. Generated files in $(outpath)." ARGS
end
