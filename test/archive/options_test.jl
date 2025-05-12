
using RackSections, JSON3, StructTypes, RackSectionsAPI



E = 29500.0
ν = 0.30

#' ### Inputs

member_type = "beam"
section_type = "step beam"
H = 4.0 
D = 3.0
W = 2.0
L = 1.0
R = 0.125 + 0.100
t = 0.100

input = RackSections.Beams.StepBeamInput(H, D, W, L, R, t, E, ν)

properties = RackSections.Beams.step_beam(input)


geometry_and_matprops = JSON3.write(input)


all_inputs = RackSectionsAPI.Inputs(member_type, section_type, geometry_and_matprops, true, true)

#this is what Epiq will send
event_data = JSON3.write(all_inputs)

properties = RackSectionsAPI.perform_calculation(event_data)



