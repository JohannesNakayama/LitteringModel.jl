include(joinpath("src", "LitteringModel.jl"))

@time begin
    include(joinpath("config", "cfg_garbage_collection.jl"))
    LitteringModel.run_batch(
        configs=configs, replicates=5, batchname="garbage_collection", compress=true
    )
end
