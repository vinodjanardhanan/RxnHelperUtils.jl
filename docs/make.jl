using RxnHelperUtils
using Documenter

DocMeta.setdocmeta!(RxnHelperUtils, :DocTestSetup, :(using RxnHelperUtils); recursive=true)

makedocs(;
    modules=[RxnHelperUtils],
    authors="Vinod Janardhanan",
    repo="https://github.com/vinodjanardhanan/RxnHelperUtils.jl/blob/{commit}{path}#{line}",
    sitename="RxnHelperUtils.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://vinodjanardhanan.github.io/RxnHelperUtils.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/vinodjanardhanan/RxnHelperUtils.jl",
    devbranch="main",
)
