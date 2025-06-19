using JSON3, RackSections, StructTypes, RackSectionsAPI


member_type = "beam"
section_type = "step_beam"
H = 4.0 
D = 3.0
W = 2.0
L = 1.0
R = 0.125 + 0.100
t = 0.100

create_output_binary = true 
CUFSM_figure_files_bucket_name = joinpath("epiq-cufsm-files", member_type, section_type, "CUFSM_figures")

create_CUFSM_MAT_files = true
CUFSM_MAT_files_bucket_name = joinpath("epiq-cufsm-files", member_type, section_type, "CUFSM_MAT")


section_details = RackSections.Beams.StepBeamInput(H, D, W, L, R, t, E, ν)
api_inputs = RackSectionsAPI.Inputs(member_type, section_type, section_details, create_output_binary, CUFSM_figure_files_bucket_name, create_CUFSM_MAT_files, CUFSM_MAT_files_bucket_name)
event_data = JSON3.write(api_inputs)
section_outputs = RackSectionsAPI.handle_event(event_data, String[])

write_input_output_jsons(JSON_file_path, member_type, section_type, api_inputs, section_outputs)



member_type = "beam"
section_type = "angled_step_beam"
H = 4.0 
D = 3.0
W = 2.0
L = 1.0
A = 81.0
R = 0.125 + 0.100
t = 0.100

create_output_binary = true 
CUFSM_figure_files_bucket_name = joinpath("epiq-cufsm-files", member_type, section_type, "CUFSM_figures")

create_CUFSM_MAT_files = true
CUFSM_MAT_files_bucket_name = joinpath("epiq-cufsm-files", member_type, section_type, "CUFSM_MAT")


section_details = RackSections.Beams.AngledStepBeamInput(H, D, W, L, A, R, t, E, ν)
api_inputs = RackSectionsAPI.Inputs(member_type, section_type, section_details, create_output_binary, CUFSM_figure_files_bucket_name, create_CUFSM_MAT_files, CUFSM_MAT_files_bucket_name)
event_data = JSON3.write(api_inputs)
section_outputs = RackSectionsAPI.handle_event(event_data, String[])

write_input_output_jsons(JSON_file_path, member_type, section_type, api_inputs, section_outputs)