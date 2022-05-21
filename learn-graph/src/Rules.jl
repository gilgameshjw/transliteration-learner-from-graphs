

# computations state
dataSTATE = Dict{String, Any}(
            "state" => nothing,
            "brain" => nothing);


# Dictionary with commands
dicCODE = Dict{String, Functor}()


# Node terminating computation
dicCODE["stream price and timestamp data"] =
    Functor((d,e=nothing,f=nothing) ->
        begin
            println(d)
            d["data_df"] = DataFrame(CSV.File(d["dataPath"]))[1:1, :]
            d
        end, # identity
        Dict(:in => [], :out => ["data_df"]))


dicCODE["calculate log price"] =
    Functor((d,e=nothing,f=nothing) ->
        (d["data_df"][!, "logPrice"] = map(p -> log(p), d["data_df"][!, "price"]);
         d),
        Dict(:in => ["data_df"], :out => ["data_df"]))


dicCODE["calculate decimal timestamp"] = 
    Functor((d,e=nothing,f=nothing) ->
        (d["data_df"][!, "logPrice"] = map(p -> log(p), d["data_df"][!, "price"]);
         d["data_df"][!,"ts_10"] = map(dt -> YearDecimal(dt).value, d["data_df"][!,"ts"]);
         d),
        Dict(:in => ["data_df"], :out => ["data_df"]))


dicCODE["is this the first record"] = 
    Functor((d,e=nothing,f=nothing) ->
        d,
        Dict(:in => [], :out => []))
