using JSON3, CairoMakie 

output = JSON3.read(joinpath(@__DIR__, "column_hat_with_lips_with_holes_in_web_output.json"))


scatterlines(output.geometry.x, output.geometry.y)
