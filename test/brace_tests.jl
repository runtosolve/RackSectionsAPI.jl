using  JSON3, RackSections, StructTypes, RackSectionsAPI, Serialization

E = 29500.0
ν = 0.30


member_type = "brace"
section_type = "cee_with_lips"
H = 3.0 
D = 3.0
L = 0.75
R = 0.125 + 0.100
t = 0.100

create_output_binary = true 
CUFSM_figure_files_bucket_name = joinpath("epiq-cufsm-files", member_type, section_type, "CUFSM_figures")

create_CUFSM_MAT_files = true
CUFSM_MAT_files_bucket_name = joinpath("epiq-cufsm-files", member_type, section_type, "CUFSM_MAT")


section_details = RackSections.Braces.CeeLipsBraceInput(H, D, L, R, t, E, ν)
api_inputs = RackSectionsAPI.Inputs(member_type, section_type, section_details, create_output_binary, CUFSM_figure_files_bucket_name)
event_data = JSON3.write(api_inputs)
section_outputs = RackSectionsAPI.handle_event(event_data, String[])

write_input_output_jsons(JSON_file_path, member_type, section_type, api_inputs, section_outputs)



member_type = "brace"
section_type = "cee"
H = 3.0 
D = 1.5
R = 0.125 + 0.100
t = 0.100

create_output_binary = true 
CUFSM_figure_files_bucket_name = joinpath("epiq-cufsm-files", member_type, section_type, "CUFSM_figures")

section_details = RackSections.Braces.CeeInput(H, D, R, t, E, ν)
api_inputs = RackSectionsAPI.Inputs(member_type, section_type, section_details, create_output_binary, CUFSM_figure_files_bucket_name)
event_data = JSON3.write(api_inputs)
section_outputs = RackSectionsAPI.handle_event(event_data, String[])

write_input_output_jsons(JSON_file_path, member_type, section_type, api_inputs, section_outputs)

member_type = "brace"
section_type = "pipe"
D = 3.0
t = 0.100

create_output_binary = true 
CUFSM_figure_files_bucket_name = joinpath("epiq-cufsm-files", member_type, section_type, "CUFSM_figures")

section_details = RackSections.Braces.PipeInput(D, t, E, ν)
api_inputs = RackSectionsAPI.Inputs(member_type, section_type, section_details, create_output_binary, CUFSM_figure_files_bucket_name)
event_data = JSON3.write(api_inputs)
section_outputs = RackSectionsAPI.handle_event(event_data, String[])

write_input_output_jsons(JSON_file_path, member_type, section_type, api_inputs, section_outputs)

member_type = "brace"
section_type = "formed_angle"
H = 2.0
D = 2.0
R = 0.125 + 1/8
t = 1/8

# CUFSM_MAT_files_bucket_name = joinpath("epiq-cufsm-files", member_type, section_type, "CUFSM_MAT")

create_output_binary = true 
CUFSM_figure_files_bucket_name = joinpath("epiq-cufsm-files", member_type, section_type, "CUFSM_figures")

section_details = RackSections.Braces.AngleInput(H, D, R, t, E, ν)
api_inputs = RackSectionsAPI.Inputs(member_type, section_type, section_details, create_output_binary, CUFSM_figure_files_bucket_name)
event_data = JSON3.write(api_inputs)
section_outputs = RackSectionsAPI.handle_event(event_data, String[])

write_input_output_jsons(JSON_file_path, member_type, section_type, api_inputs, section_outputs)

member_type = "brace"
section_type = "closed_tube"
H = 2.0
D = 2.0
R = 0.125 + 1/8
t = 1/8


create_output_binary = true 
CUFSM_figure_files_bucket_name = joinpath("epiq-cufsm-files", member_type, section_type, "CUFSM_figures")

section_details = RackSections.Braces.RectangularTubeBraceInput(H, D, R, t, E, ν)
api_inputs = RackSectionsAPI.Inputs(member_type, section_type, section_details, create_output_binary, CUFSM_figure_files_bucket_name)
event_data = JSON3.write(api_inputs)
section_outputs = RackSectionsAPI.handle_event(event_data, String[])

write_input_output_jsons(JSON_file_path, member_type, section_type, api_inputs, section_outputs)
