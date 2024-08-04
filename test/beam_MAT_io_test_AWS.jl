using  JSON3, RackSections, StructTypes, RackSectionsAPI, CUFSM, Base64


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

section_inputs = RackSections.Beams.StepBeamInput(H, D, W, L, R, t, E, ν)

section_inputs_json = JSON3.write(section_inputs)

api_inputs = RackSectionsAPI.Inputs(member_type, section_type, section_inputs_json, true, true)

section = RackSections.Beams.step_beam(section_inputs)

file_name = "CUFSM_beam_julia.mat"
file_path = "/tmp/"

model = section.local_buckling_Mxx_neg
bitstream_data = RackSectionsAPI.save_MAT_file_to_IO(model, file_path, file_name)



