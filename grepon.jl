import GitHub
import Dates

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

println(range)
