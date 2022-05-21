
using Graphs
using CSV
using YAML
using DataFrames
using ArgParse
using Serialization
using Dates, DateFormats


include("src/Graphs.jl")
include("src/Agent.jl")
include("src/Rules.jl")



function parse_commandline()

    s = ArgParseSettings()

    @add_arg_table! s begin

        "--path-model"
            help = "path to the train model"
        #"--flow-name"
        #    help = "brain name to be ran"

    end

    parse_args(s)

end


# parse commands
parsedArgs = parse_commandline()


# load brain data
data = deserialize(parsedArgs["path-model"])


stateData = YAML.load_file("data/state-data.yml")


# Build data
entryBrain = data[:entry]
dicBRAINS = data[:dicBrains]
df_Nodes = data[:df_Nodes]
graph = dicBRAINS[entryBrain]


stateData = stateData[entryBrain]
#===
Dict{String, Any}(
            "txt" => parsedArgs["text"],
            "state" => nothing, # used for messages back to system
            "brain" => entryBrain)
===#

# run agent
runAgent(graph, dicBRAINS, df_Nodes, stateData) |>
    println


"####################################################################" |> println
"###########################  END ###################################" |> println
"####################################################################" |> println
