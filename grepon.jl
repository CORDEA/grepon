import GitHub

if length(ARGS) <= 2
    return
end

owner = ARGS[1]
auth = GitHub.authenticate(ENV["GITHUB_TOKEN"])

params = Dict("type" => "public", "sort" => "created")
repos, next = GitHub.repos(owner; auth = auth, params = params)
println(length(repos))
