module LitteringModel

    using Agents
    using DataFrames
    using LightGraphs
    using Random
    using StatsBase
    using Feather
    using JSON
    using Distributions
    using GraphIO
    using Distributed
    using Pipe
    using Query
    using Statistics
    using ProgressMeter

    include("citizen.jl")
    include("config.jl")
    include("io.jl")
    include("formatting.jl")
    include("initialization.jl")
    include("agent_step.jl")
    include("model_step.jl")
    include("simulation.jl")

    export Config
    export initialize_model

end
