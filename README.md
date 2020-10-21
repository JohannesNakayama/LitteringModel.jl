# LitteringModel.jl

Simulation of an individual littering behavior influenced by social normative perceptions and personality attributes in a heterogeneous agent population. 


## Prerequesites

This model was build in Julia 1.4.2. It depends on the third-party Julia packages `Agents.jl`, `DataFrames.jl`, `LightGraphs.jl`, `StatsBase.jl`, `Feather.jl`, `JSON.jl`, `Distributions.jl`, `GraphIO.jl`, `Pipe.jl`, `Query.jl` and `ProgressMeter.jl` which can be installed directly from within the Julia package manager `Pkg.jl`. To switch to package manager, enter `]` into the REPL. To install packages, enter the following code (ommitting the `.jl`):

```
(@v1.4) pkg> add <PACKAGE_NAME>
```

A further requirement is the file archiver [7-zip](https://7-zip.org/). 7-zip needs to be in the local PATH variable. To test whether 7-zip is properly setup, run the command `7z` in a terminal.


## Usage

To reproduce my Master thesis experiment, execute the following:

```
julia>include("experiments.jl")
```

This will run all simulations that are setup in the scripts in the `config` folder. 


## Analysis

Once you have run the simulations, you can reproduce all analyses that I conducted. The analysis scripts for all experiments can be found in the folder `analysis`. Each subfolder contains an `.Rmd` script that recreates all analyses that have been run on the simulation data. The analyses scripts were written under R 4.0.2 and require the following R packages: `tidyverse`, `magrittr`, `ggpubr`, `igraph`, `arrow` and `viridis`. All of these packages are available from CRAN:

```
R>install.packages("<PACKAGE_NAME>")
```