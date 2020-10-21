function configs_to_dataframe(configs::Dict; path::String, write::Bool=false)
    config_df = init_configs_dataframe()
    progress_bar = ProgressMeter.Progress(length(keys(configs)), 0.2, "Converting configurations...")
    for config_key in keys(configs)
        config_row = extract_config(configs, config_key)
        push!(config_df, config_row)
        ProgressMeter.next!(progress_bar)
    end
    if write
        write_dataframe(df=config_df, filename="configs.feather", path=path)
    end
    return config_df
end

function init_configs_dataframe()
    return DataFrames.DataFrame(
        Config=String[],
        Nodes=Int64[],
        N0=Int64[],
        K=Int64[],
        AgentCount=Int64[],
        InitialTrash=Int64[],
        InitialLitterers=Int64[],
        GarbageCollection=Int64[],
        Iterations=Int64[]
    )
end

function extract_config(configs::Dict, config_key::Any)
    return (
        Config="config_" * lpad(config_key, 2, "0"),
        Nodes=configs[config_key].n_nodes,
        N0=configs[config_key].n0,
        K=configs[config_key].k,
        AgentCount=configs[config_key].agentcount,
        InitialTrash=configs[config_key].initial_trash,
        InitialLitterers=configs[config_key].initial_litterers,
        GarbageCollection=configs[config_key].garbage_collection,
        Iterations=configs[config_key].n_iter
    )
end

function names_to_camelcase!(df::DataFrames.DataFrame)
    new_colnames = [to_camelcase(name) for name in names(df)]
    rename!(df, Symbol.(new_colnames))
    return df
end

function to_camelcase(varname::String)
	varname_split_titlecase = titlecase.(split(deepcopy(varname), "_"))
	varname_modified = join(varname_split_titlecase, "")
	return varname_modified
end
