struct Config
    n_nodes::Int64
    n0::Int64
    k::Int64
    agentcount::Int64
    initial_trash::Int64
    initial_litterers::Int64
    garbage_collection::Int64
    n_iter::Int64
end

Config(;
    n_nodes::Int64, n0::Int64, k::Int64, 
    agentcount::Int64, initial_trash::Int64, 
    initial_litterers::Int64, garbage_collection::Int64,
    n_iter::Int64
) = Config(
    n_nodes, n0, k, 
    agentcount, initial_trash, 
    initial_litterers, garbage_collection,
    n_iter
)

Config() = Config(
    n_nodes=1_000, n0=3, k=3, 
    agentcount=100, initial_trash=500, 
    initial_litterers=20, garbage_collection=0,
    n_iter=1_000
)
