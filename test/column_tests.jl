using  JSON3, RackSections, StructTypes, RackSectionsAPI

E = 29500.0
ν = 0.30

#' ### Inputs

member_type = "column"
section_type = "closed_tube"
H = 3.0 
D = 3.0
L = 0.75
R = 0.125 + 0.100
t = 0.100
dh_H = 0.710
dh_D = 0.531
de_H  = H/2 - 0.700
de_D = 0.875
hole_pitch_H = 2.0
hole_pitch_D = 2.0
hole_length_H = 1.086
hole_length_D = 0.531


# H = 3.0 
# D = 3.0
# L = 0.75
# R = 0.125
# t = 0.12
# dh_H = 0.5
# dh_D = 0.5
# de_H  = 1.0
# de_D = 1.0
# hole_pitch_H = 4.0
# hole_pitch_D = 4.0
# hole_length_H = 0.5
# hole_length_D = 0.5

create_output_binary = true 
CUFSM_figure_files_bucket_name = joinpath("epiq-cufsm-files", member_type, section_type, "CUFSM_figures")

create_CUFSM_MAT_files = true
CUFSM_MAT_files_bucket_name = joinpath("epiq-cufsm-files", member_type, section_type, "CUFSM_MAT")


section_details = RackSections.Columns.RectangularTubeInput(H, D, R, t, E, ν, dh_H, dh_D, de_H, de_D, hole_pitch_H, hole_pitch_D, hole_length_H, hole_length_D)
api_inputs = RackSectionsAPI.Inputs(member_type, section_type, section_details, create_output_binary, CUFSM_figure_files_bucket_name, create_CUFSM_MAT_files, CUFSM_MAT_files_bucket_name)
event_data = JSON3.write(api_inputs)
section_outputs = RackSectionsAPI.handle_event(event_data, String[])

write_input_output_jsons(JSON_file_path, member_type, section_type, api_inputs, section_outputs)


member_type = "column"
section_type = "cee_with_lips"
H = 3.0 
D = 3.0
L = 0.75
R = 0.125 + 0.100
t = 0.100
dh_H = 0.710
dh_D = 0.531
de_H  = H/2 - 0.700
de_D = 0.875
hole_pitch_H = 2.0
hole_pitch_D = 2.0
hole_length_H = 1.086
hole_length_D = 0.531;

create_output_binary = true 
CUFSM_figure_files_bucket_name = joinpath("epiq-cufsm-files", member_type, section_type, "CUFSM_figures")

create_CUFSM_MAT_files = true
CUFSM_MAT_files_bucket_name = joinpath("epiq-cufsm-files", member_type, section_type, "CUFSM_MAT")


section_details = RackSections.Columns.CeeLipsInput(H, D, L, R, t, E, ν, dh_H, dh_D, de_H, de_D, hole_pitch_H, hole_pitch_D, hole_length_H, hole_length_D)
api_inputs = RackSectionsAPI.Inputs(member_type, section_type, section_details, create_output_binary, CUFSM_figure_files_bucket_name, create_CUFSM_MAT_files, CUFSM_MAT_files_bucket_name)
event_data = JSON3.write(api_inputs)
section_outputs = RackSectionsAPI.handle_event(event_data, String[])

write_input_output_jsons(JSON_file_path, member_type, section_type, api_inputs, section_outputs)


member_type = "column"
section_type = "cee_with_lips_and_rib"

H = 3.0 
D = 3.0
L = 0.75
R = 0.125 + 0.100
t = 0.100
dh_H = 0.710
dh_D = 0.531
de_H  = H/2 - 0.700
de_D = 0.875
hole_pitch_H = 2.0
hole_pitch_D = 2.0
hole_length_H = 1.086
hole_length_D = 0.531
H_rib = 0.25  
R_rib_flat = 3 * t
R_rib_peak = 3 * t

create_output_binary = true 
CUFSM_figure_files_bucket_name = joinpath("epiq-cufsm-files", member_type, section_type, "CUFSM_figures")

create_CUFSM_MAT_files = true
CUFSM_MAT_files_bucket_name = joinpath("epiq-cufsm-files", member_type, section_type, "CUFSM_MAT")


section_details = RackSections.Columns.CeeLipsRibInput(H, D, L, R, t, E, ν, dh_H, dh_D, de_H, de_D, hole_pitch_H, hole_pitch_D, hole_length_H, hole_length_D, H_rib, R_rib_flat, R_rib_peak)
api_inputs = RackSectionsAPI.Inputs(member_type, section_type, section_details, create_output_binary, CUFSM_figure_files_bucket_name, create_CUFSM_MAT_files, CUFSM_MAT_files_bucket_name)
event_data = JSON3.write(api_inputs)
section_outputs = RackSectionsAPI.handle_event(event_data, String[])

write_input_output_jsons(JSON_file_path, member_type, section_type, api_inputs, section_outputs)

member_type = "column"
section_type = "hat_with_rib"

E = 29500.0
ν = 0.30

R = 0.125 + 0.100
t = 0.100
X  = 0.48 + t

H = 3.0
D1 = 1.02 
D2 = 1.18 
D = D1 + D2 + 0.50
dh_H = 0.510
dh_D1 = 0.431
dh_D2 = 0.531
de_H  = H/2 - 0.700
de_D1 = D1/2
de_D2 = D2/2
hole_pitch_H = 2.0
hole_pitch_D1 = 2.0
hole_pitch_D2 = 2.0
hole_length_H = 1.086
hole_length_D1 = 0.531
hole_length_D2 = 0.531
H_rib = 0.25  
R_rib_flat = 3 * t
R_rib_peak = 3 * t
A = 135.0  #degrees 


#####

create_output_binary = true 
CUFSM_figure_files_bucket_name = joinpath("epiq-cufsm-files", member_type, section_type, "CUFSM_figures")

create_CUFSM_MAT_files = true
CUFSM_MAT_files_bucket_name = joinpath("epiq-cufsm-files", member_type, section_type, "CUFSM_MAT")


section_details = RackSections.Columns.HatRibInput(H, D1, D2, D, A, R, t, E, ν, dh_H, dh_D1, dh_D2, de_H, de_D1, de_D2,
     
hole_pitch_H,
hole_pitch_D1,
hole_pitch_D2,
hole_length_H,
hole_length_D1,
hole_length_D2,

H_rib, R_rib_peak, R_rib_flat) 

api_inputs = RackSectionsAPI.Inputs(member_type, section_type, section_details, create_output_binary, CUFSM_figure_files_bucket_name, create_CUFSM_MAT_files, CUFSM_MAT_files_bucket_name)

event_data = JSON3.write(api_inputs)
section_outputs = RackSectionsAPI.handle_event(event_data, String[])

write_input_output_jsons(JSON_file_path, member_type, section_type, api_inputs, section_outputs)


member_type = "column"
section_type = "hat_with_lips_and_rib"

R = 0.125 + 0.100
t = 0.100
X  = 0.48 + t

H = 3.0
D1 = 1.02 
D2 = 1.18 
D = D1 + D2 + 0.50
dh_H = 0.510
dh_D1 = 0.431
dh_D2 = 0.531
de_H  = H/2 - 0.700
de_D1 = D1/2
de_D2 = D2/2
hole_pitch_H = 2.0
hole_pitch_D1 = 2.0
hole_pitch_D2 = 2.0
hole_length_H = 1.086
hole_length_D1 = 0.531
hole_length_D2 = 0.531
H_rib = 0.25  
R_rib_flat = 3 * t
R_rib_peak = 3 * t
A = 135.0  #degrees 
L = 0.75


create_output_binary = true 
CUFSM_figure_files_bucket_name = joinpath("epiq-cufsm-files", member_type, section_type, "CUFSM_figures")

create_CUFSM_MAT_files = true
CUFSM_MAT_files_bucket_name = joinpath("epiq-cufsm-files", member_type, section_type, "CUFSM_MAT")


section_details = RackSections.Columns.HatLipsRibInput(H, D1, D2, D, A, L, R, t, E, ν, dh_H, dh_D1, dh_D2, de_H, de_D1, de_D2,
     
hole_pitch_H,
hole_pitch_D1,
hole_pitch_D2,
hole_length_H,
hole_length_D1,
hole_length_D2,

H_rib, R_rib_peak, R_rib_flat) 

api_inputs = RackSectionsAPI.Inputs(member_type, section_type, section_details, create_output_binary, CUFSM_figure_files_bucket_name, create_CUFSM_MAT_files, CUFSM_MAT_files_bucket_name)
event_data = JSON3.write(api_inputs)
section_outputs = RackSectionsAPI.handle_event(event_data, String[])

write_input_output_jsons(JSON_file_path, member_type, section_type, api_inputs, section_outputs)


member_type = "column"
section_type = "hat_with_lips_and_trapezoidal_rib"


R = 0.125 + 0.100
t = 0.100


A1 = 135.0

H = 4.0
D1 = 1.02 
D2 = 1.18 
D = D1 + D2 + 0.50
L = 0.39
dh_H = 0.710
dh_D1 = 0.431
dh_D2 = 0.531
de_H  = 0.8
de_D1 = D1/2
de_D2 = D2/2
hole_pitch_H = 2.0
hole_pitch_D1 = 2.0
hole_pitch_D2 = 2.0
hole_length_H = 1.086
hole_length_D1 = 0.531
hole_length_D2 = 0.531
W_rib = 0.50
H_rib = 0.50
Rr = 0.125 + 0.100
A2 = 135.0

create_output_binary = true 
CUFSM_figure_files_bucket_name = joinpath("epiq-cufsm-files", member_type, section_type, "CUFSM_figures")

create_CUFSM_MAT_files = true
CUFSM_MAT_files_bucket_name = joinpath("epiq-cufsm-files", member_type, section_type, "CUFSM_MAT")


section_details = RackSections.Columns.HatLipsTrapezoidalRibInput(H, D1, D2, D, A1, L, R, t, E, ν, dh_H, dh_D1, dh_D2, de_H, de_D1, de_D2, hole_pitch_H, hole_pitch_D1, hole_pitch_D2, hole_length_H, hole_length_D1, hole_length_D2, A2, H_rib, W_rib)
api_inputs = RackSectionsAPI.Inputs(member_type, section_type, section_details, create_output_binary, CUFSM_figure_files_bucket_name, create_CUFSM_MAT_files, CUFSM_MAT_files_bucket_name)
event_data = JSON3.write(api_inputs)
section_outputs = RackSectionsAPI.handle_event(event_data, String[])

write_input_output_jsons(JSON_file_path, member_type, section_type, api_inputs, section_outputs)

member_type = "column"
section_type = "unistrut_with_lips_in"

E = 29500.0
ν = 0.30

H = 3.0 
D = 3.0
L1 = 0.75
L2 = 0.75
R = 0.125 + 0.100
t = 0.100
dh_H = 0.710
dh_D = 0.531
de_H  = H/2 - 0.700
de_D = 0.875
hole_pitch_H = 2.0
hole_pitch_D = 2.0
hole_length_H = 1.086
hole_length_D = 0.531
H_rib = 0.25  
R_rib_flat = 3 * t
R_rib_peak = 3 * t

create_output_binary = true 
CUFSM_figure_files_bucket_name = joinpath("epiq-cufsm-files", member_type, section_type, "CUFSM_figures")

create_CUFSM_MAT_files = true
CUFSM_MAT_files_bucket_name = joinpath("epiq-cufsm-files", member_type, section_type, "CUFSM_MAT")


section_details = RackSections.Columns.UniStrutInput(H, D, L1, L2, R, t, E, ν, dh_H, dh_D, de_H, de_D, hole_pitch_H, hole_pitch_D, hole_length_H, hole_length_D, H_rib, R_rib_flat, R_rib_peak)
api_inputs = RackSectionsAPI.Inputs(member_type, section_type, section_details, create_output_binary, CUFSM_figure_files_bucket_name, create_CUFSM_MAT_files, CUFSM_MAT_files_bucket_name)
event_data = JSON3.write(api_inputs)
section_outputs = RackSectionsAPI.handle_event(event_data, String[])

write_input_output_jsons(JSON_file_path, member_type, section_type, api_inputs, section_outputs)

member_type = "column"
section_type = "unistrut_with_lips_out"

H = 3.0 
D = 3.0
L1 = 0.75
L2 = 0.75
R = 0.125 + 0.100
t = 0.100
dh_H = 0.710
dh_D = 0.531
de_H  = H/2 - 0.700
de_D = 0.875
hole_pitch_H = 2.0
hole_pitch_D = 2.0
hole_length_H = 1.086
hole_length_D = 0.531
H_rib = 0.25  
R_rib_flat = 3 * t
R_rib_peak = 3 * t

create_output_binary = true 
CUFSM_figure_files_bucket_name = joinpath("epiq-cufsm-files", member_type, section_type, "CUFSM_figures")

create_CUFSM_MAT_files = true
CUFSM_MAT_files_bucket_name = joinpath("epiq-cufsm-files", member_type, section_type, "CUFSM_MAT")


section_details = RackSections.Columns.UniStrutInput(H, D, L1, L2, R, t, E, ν, dh_H, dh_D, de_H, de_D, hole_pitch_H, hole_pitch_D, hole_length_H, hole_length_D, H_rib, R_rib_flat, R_rib_peak)
api_inputs = RackSectionsAPI.Inputs(member_type, section_type, section_details, create_output_binary, CUFSM_figure_files_bucket_name, create_CUFSM_MAT_files, CUFSM_MAT_files_bucket_name)
event_data = JSON3.write(api_inputs)
section_outputs = RackSectionsAPI.handle_event(event_data, String[])

write_input_output_jsons(JSON_file_path, member_type, section_type, api_inputs, section_outputs)


