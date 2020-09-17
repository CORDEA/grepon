import GitHub
import Dates
import Plots

if length(ARGS) <= 2
    return
end

owner = ARGS[1]
auth = GitHub.authenticate(ENV["GITHUB_TOKEN"])

params = Dict("type" => "public", "sort" => "created")
repos, next = GitHub.repos(owner; auth = auth, params = params)

range = Dict()
date = floor(Dates.now() + Dates.Month(1), Dates.Month)
for repo in repos
    if date > repo.created_at
       global date -= Dates.Month(1)
    end
    if haskey(range, date)
        push!(range[date], repo)
    else
        range[date] = [repo]
    end
end

arr = collect(range)
sort!(arr, by = x -> x.first)

count = map(x -> Pair(x.first, length(x.second)), arr)
println(count)

plot = Plots.plot(map(x -> x.first, count), map(x -> x.second, count))
Plots.png(plot, "plot.png")
