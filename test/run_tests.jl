JSON_file_path = joinpath(@__DIR__, "json")

include(joinpath(@__DIR__, "test_helpers.jl"))

include(joinpath(@__DIR__, "brace_tests.jl"))

include(joinpath(@__DIR__, "beam_tests.jl"))

include(joinpath(@__DIR__, "column_tests.jl"))