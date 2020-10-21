function model_step!(model::Agents.ABM)
    model.new_trash = sum(model.trash_in_spaces) - model.trash_aggregated
    collect_garbage!(model)
    model.trash_aggregated = sum(model.trash_in_spaces)    
    return model
end

function collect_garbage!(model::Agents.ABM)
    model.trash_in_spaces = model.trash_in_spaces .- model.garbage_collection
    model.trash_in_spaces = [i >= 0 ? i : 0 for i in model.trash_in_spaces]
    return model
end







