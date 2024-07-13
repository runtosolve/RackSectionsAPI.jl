using  JSON3, RackSections, StructTypes, CUFSM, Base64, RackSectionsAPI, LinesCurvesNodes, CairoMakie

E = 29500.0
ν = 0.30

#' ### Inputs

H = 4.0 
D = 3.0
W = 2.0
L = 1.0
R = 0.125 + 0.100
t = 0.100

input = RackSections.Beams.StepBeamInput(H, D, W, L, R, t, E, ν)
section = RackSections.Beams.step_beam(input)



all_figures_IO, all_figures = RackSectionsAPI.Show.step_beam(section)    


model = section.local_buckling_P 
eig = 1
deformation_scale = (1.0, 1.0)
num_elem = length(section.geometry.x)
t = fill(t, num_elem)
drawing_scale = 1.0


ax, figure = CUFSM.Show.minimum_mode_shape(model, eig, t, deformation_scale, drawing_scale)

######


# Pcr = CUFSM.Tools.get_load_factor(model, eig)
#     mode_index = argmin(Pcr)
#     mode = model.shapes[mode_index][:, eig]

#     n = fill(5, length(t))

#     cross_section_coords, Δ, figure_max_dims = CUFSM.Show.cross_section_mode_shape_info(model.elem, model.node, mode, n, deformation_scale)

#     XY_discretized =Float64[]
#     t_discretized = Float64[]
#     Δ_discretized = Float64[]

#     for i in eachindex(cross_section_coords)

#         XY_segment = [cross_section_coords[i][j] for j in eachindex(cross_section_coords[i])][1:end-1]
#         XY_discretized = vcat(XY_discretized, XY_segment)

#         t_discretized = vcat(t_discretized, fill(t[i], n[i]-1))

#         Δ_segment = [Δ[i][j] for j in eachindex(Δ[i])][1:end-1]
#         Δ_discretized = vcat(Δ_discretized, Δ_segment)

#     end

#     X_discretized = [XY_discretized[i][1] for i in eachindex(XY_discretized)]
#     Y_discretized = [XY_discretized[i][2] for i in eachindex(XY_discretized)]

#     ΔX_discretized = [Δ_discretized[i][1] for i in eachindex(Δ_discretized)]
#     ΔY_discretized = [Δ_discretized[i][2] for i in eachindex(Δ_discretized)]

#     linesegment_ranges, t_segments = LinesCurvesNodes.find_linesegments(t_discretized)
#     coords_as_linesegments = LinesCurvesNodes.combine_points_into_linesegments(linesegment_ranges, X_discretized, Y_discretized)
#     Δ_as_linesegments = LinesCurvesNodes.combine_points_into_linesegments(linesegment_ranges, ΔX_discretized, ΔY_discretized)


#     figure_span_x = figure_max_dims[1]
#     figure_span_y = figure_max_dims[2]

#     figure = Figure(size = (figure_span_x*72, figure_span_y*72) .* drawing_scale)
#     ax = Axis(figure[1, 1], aspect = figure_span_x/figure_span_y)
#     hidedecorations!(ax)  # hides ticks, grid and lables
#     hidespines!(ax)  # hide the frame
#     # thickness_scale = maximum(t) * 72 * drawing_scale
#     # linewidths = t ./ maximum(t) * thickness_scale

#     thickness_scale = maximum(t_segments) * 72 * drawing_scale
#     linewidths = t_segments ./ maximum(t_segments) * thickness_scale
    
#     attributes = (color=:grey, linestyle=:solid)

#     # linesegment_ranges = LinesCurvesNodes.find_line_segments(linewidths)

#     # [show_element_deformed_shape!(ax, cross_section_coords[i], Δ[i], deformation_scale, attributes, attributes.linewidth[i]) for i in eachindex(Δ)];
   
#     [CUFSM.Show.show_element_deformed_shape!(ax, coords_as_linesegments[i], Δ_as_linesegments[i], deformation_scale, attributes, linewidths[i]) for i in eachindex(Δ_as_linesegments)];


#     if length(X_discretized) == length(t_discretized)  #closed section

#         coords_last_linesegment = Vector{Vector{Float64}}(undef, 2)
#         Δ_last_linesegment = Vector{Vector{Float64}}(undef, 2)

#         coords_last_linesegment[1] = coords_as_linesegments[end][end]
#         coords_last_linesegment[2] = coords_as_linesegments[1][1]

#         Δ_last_linesegment[1] = Δ_as_linesegments[end][end]
#         Δ_last_linesegment[2] = Δ_as_linesegments[1][1]

#         CUFSM.Show.show_element_deformed_shape!(ax, coords_last_linesegment, Δ_last_linesegment, deformation_scale, attributes, linewidths[end])

#     end

#     # coords_as_linesegments[[end, 1]]


# #####

# coords_last_linesegment = Vector{Vector{Float64}}(undef, 2)
# Δ_last_linesegment = Vector{Vector{Float64}}(undef, 2)

# coords_last_linesegment[1] = coords_as_linesegments[end][end]
# coords_last_linesegment[2] = coords_as_linesegments[1][1]


# Δ_last_linesegment[1] = Δ_as_linesegments[end][end]
# Δ_last_linesegment[2] = Δ_as_linesegments[1][1]





drawing_scale = 1.0
line_color = :grey
x = section.geometry.x
y = section.geometry.y
num_elem = length(x)
t_all = fill(t, num_elem)

figure = RackSectionsAPI.Show.section(x, y, t_all, drawing_scale, line_color)





