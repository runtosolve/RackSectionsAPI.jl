using  JSON3, RackSections, StructTypes, RackSectionsAPI

E = 29500.0
ν = 0.30


member_type = "brace"
section_type = "cee with lips"
H = 3.0 
D = 3.0
L = 0.75
R = 0.125 + 0.100
t = 0.100

input = RackSections.Braces.CeeLipsBraceInput(member_type, section_type, H, D, L, R, t, E, ν)
event_data = JSON3.write(input)
section_outputs = RackSectionsAPI.handle_event(event_data, String[])


member_type = "brace"
section_type = "cee"
H = 3.0 
D = 1.5
R = 0.125 + 0.100
t = 0.100

input = RackSections.Braces.CeeInput(member_type, section_type, H, D, R, t, E, ν);
event_data = JSON3.write(input)
section_outputs = RackSectionsAPI.handle_event(event_data, String[])


member_type = "brace"
section_type = "pipe"
D = 3.0
t = 0.100

input = RackSections.Braces.PipeInput(member_type, section_type, D, t, E, ν);
event_data = JSON3.write(input)
section_outputs = RackSectionsAPI.handle_event(event_data, String[])

member_type = "brace"
section_type = "formed angle"
H = 2.0
D = 2.0
R = 0.125 + 1/8
t = 1/8

input = RackSections.Braces.AngleInput(member_type, section_type, H, D, R, t, E, ν);
event_data = JSON3.write(input)
section_outputs = RackSectionsAPI.handle_event(event_data, String[])

member_type = "brace"
section_type = "closed tube"
H = 2.0
D = 2.0
R = 0.125 + 1/8
t = 1/8

input = RackSections.Braces.RectangularTubeBraceInput(member_type, section_type, H, D, R, t, E, ν);
event_data = JSON3.write(input)
section_outputs = RackSectionsAPI.handle_event(event_data, String[])