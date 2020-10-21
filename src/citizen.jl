mutable struct Citizen <: Agents.AbstractAgent
    id::Int64
    pos::Int64
    socialnorm::Float64
    conscientiousness::Float64
    littering::Bool
end

Citizen(; 
    id::Int64, pos::Int64, socialnorm::Float64, conscientiousness::Float64, littering::Bool
) = Citizen(id, pos, socialnorm, conscientiousness, littering)

Citizen(id, pos, littering) = Citizen(
    id=id, pos=pos, socialnorm=0.0, conscientiousness=randn_unit(), littering=littering
)

function randn_unit()
    normal_distribution = Distributions.Normal(0.5, 0.2)
    random_normal_number = Distributions.rand(normal_distribution)
    if (random_normal_number < 0) | (random_normal_number > 1)
        random_normal_number = randn_unit()
    end
    return random_normal_number
end
