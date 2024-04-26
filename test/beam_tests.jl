using  JSON3, RackSections, StructTypes, RackSectionsAPI

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

input = RackSections.Beams.StepBeamInput(member_type, section_type, H, D, W, L, R, t, E, ν)
event_data = JSON3.write(input)
section_outputs = RackSectionsAPI.handle_event(event_data, String[])


member_type = "beam"
section_type = "angled step beam"
H = 4.0 
D = 3.0
W = 2.0
L = 1.0
A = π/2*0.9
R = 0.125 + 0.100
t = 0.100

input = RackSections.Beams.AngledStepBeamInput(member_type, section_type, H, D, W, L, A, R, t, E, ν)
event_data = JSON3.write(input)
section_outputs = RackSectionsAPI.handle_event(event_data, String[])

