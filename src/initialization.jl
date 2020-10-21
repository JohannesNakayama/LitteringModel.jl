function create_space(config::Config)
    base_space = LightGraphs.barabasi_albert(config.n_nodes, config.n0, config.k)
    return Agents.GraphSpace(base_space)
end

function initialize_model(config::Config, space::Agents.GraphSpace)
    properties = get_model_properties(config)
    model = Agents.AgentBasedModel(Citizen, space; properties=properties, scheduler=random_activation)
    populate_space!(model, config)
    distribute_littering!(model, config)
    model.trash_aggregated = sum(model.trash_in_spaces)
    model.new_trash = deepcopy(model.trash_aggregated)
    return model
end

function get_model_properties(config::Config)
    return Dict(
        :agentcount => config.agentcount,
        :cost_matrix => [2 2; 3 1],
        :clock => 0,
        :garbage_collection => config.garbage_collection,
        :trash_in_spaces => zeros(Int64, config.n_nodes),
        :trash_aggregated => 0,
        :new_trash => 0
    )
end

function populate_space!(model::Agents.ABM, config::Config)
    ids_initial_litterers = StatsBase.sample(1:config.agentcount, config.initial_litterers, replace=false)
    for id in 1:config.agentcount
        pos = StatsBase.sample(1:config.n_nodes)
        if !(id in ids_initial_litterers)
            Agents.add_agent_pos!(Citizen(id, pos, false), model)
        else
            Agents.add_agent_pos!(Citizen(id, pos, true), model)
        end
    end
    return model
end

function distribute_littering!(model::Agents.ABM, config::Config)
    for i in 1:config.initial_trash
        space_to_trash = StatsBase.sample(1:config.n_nodes)
        model.trash_in_spaces[space_to_trash] += 1
    end
    return model
end