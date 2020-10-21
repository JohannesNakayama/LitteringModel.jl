configs = Dict()
for (i, garbage_collection) in enumerate(0:1:30)
    configs[i] = LitteringModel.Config(
        n_nodes=100,
        n0=3,
        k=3,
        agentcount=500,
        initial_trash=100,
        initial_litterers=5,
        garbage_collection=garbage_collection,
        n_iter=100
    )
end
