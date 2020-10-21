function agent_step!(agent::Agents.AbstractAgent, model::Agents.ABM)
    move_agent_random!(agent, model)
    update_socialnorm!(agent, model)
    choose_strategy!(agent, model)
    litter!(agent, model)
    return agent
end

function move_agent_random!(agent::Agents.AbstractAgent, model::Agents.ABM)
    adjacent_places = node_neighbors(agent.pos, model)
    new_position = StatsBase.sample(adjacent_places)
    Agents.move_agent!(agent, new_position, model)
    return agent
end

function update_socialnorm!(agent::Agents.AbstractAgent, model::Agents.ABM)
    neighbor_behavior = [
        i.littering
        for i in Agents.get_node_agents(agent.pos, model)
        if !(i === agent)
    ]
    if length(neighbor_behavior) > 0
        agent.socialnorm = StatsBase.mean(neighbor_behavior)
    else
        agent.socialnorm = 1 - agent.conscientiousness
    end
    return agent
end

function choose_strategy!(agent::Agents.AbstractAgent, model::Agents.ABM)
    weight = compute_weight(agent, model)
    costmatrix = compute_costmatrix(weight, model)
    if (littering_is_dominant(costmatrix))
        agent.littering = true
    elseif (not_littering_is_dominant(costmatrix))
        agent.littering = false
    else
        agent.littering = biased_coin(weight)
    end
    return agent
end

function compute_weight(agent::Agents.AbstractAgent, model::Agents.ABM)
    weight = StatsBase.mean([
        agent.socialnorm,
        1 - agent.conscientiousness
    ])
    for i in 1:model.trash_in_spaces[agent.pos]
        weight = pump(weight)
    end
    return weight
end

function pump(x)
    return tanh(x) / tanh(1)
end

function compute_costmatrix(weight::Float64, model::Agents.ABM)
    costmatrix = (
        [(1 - weight) (1 - weight); weight weight]
        .* model.cost_matrix
    )
    return costmatrix
end

function littering_is_dominant(costmatrix::AbstractArray)
    is_dominant = (
        (costmatrix[1, 1] < costmatrix[2, 1])
        & (costmatrix[1, 2] < costmatrix[2, 2])
    )
    return is_dominant
end

function not_littering_is_dominant(costmatrix::AbstractArray)
    is_dominant = (
        (costmatrix[1, 1] > costmatrix[2, 1])
        & (costmatrix[1, 2] > costmatrix[2, 2])
    )
    return is_dominant
end

function biased_coin(weight::Float64)
    return Random.rand() < weight ? true : false
end

function litter!(agent::Agents.AbstractAgent, model::Agents.ABM)
    if agent.littering
        model.trash_in_spaces[agent.pos] += 1
    end
    return model
end