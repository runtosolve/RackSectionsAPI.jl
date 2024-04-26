using  JSON3, RackSections, StructTypes, RackSectionsAPI

E = 29500.0
ν = 0.30

#' ### Inputs

member_type = "column"
section_type = "closed tube"
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

input = RackSections.Columns.RectangularTubeInput(member_type, section_type, H, D, R, t, E, ν, dh_H, dh_D, de_H, de_D, hole_pitch_H, hole_pitch_D, hole_length_H, hole_length_D)
event_data = JSON3.write(input)
section_outputs = RackSectionsAPI.handle_event(event_data, String[])

member_type = "column"
section_type = "cee with lips"
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

input = RackSections.Columns.CeeLipsInput(member_type, section_type, H, D, L, R, t, E, ν, dh_H, dh_D, de_H, de_D, hole_pitch_H, hole_pitch_D, hole_length_H, hole_length_D)
event_data = JSON3.write(input)
section_outputs = RackSectionsAPI.handle_event(event_data, String[])


member_type = "column"
section_type = "cee with lips and rib"
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
rib_depth = 0.123  
rib_length = rib_depth * 4
rib_radius_start = 0.1880*0.5 + t  
rib_radius_peak = 0.1880*0.45
input = RackSections.Columns.CeeLipsRibInput(member_type, section_type, H, D, L, R, t, E, ν, dh_H, dh_D, de_H, de_D, hole_pitch_H, hole_pitch_D, hole_length_H, hole_length_D, rib_depth, rib_length, rib_radius_start, rib_radius_peak)
event_data = JSON3.write(input)
section_outputs = RackSectionsAPI.handle_event(event_data, String[])



member_type = "column"
section_type = "hat with rib"

R = 0.125 + 0.100
t = 0.100
X  = 0.48 + t

using Roots
f(A) = -(atan((X-t)/(0.51 - R * tan((π-A)/2) - (R-t) * tan((π-A)/2))) - π) - A
A = find_zero(f, π/2)
Z = 0.51 - R * tan((π-A)/2) - (R-t) * tan((π-A)/2)

Δ = π - A
T = R * tan(Δ/2)

α = A - π/2
yc = t * tan(α)

H = 3.0
D1 = 1.02 + T
D2 = 1.18 + T
D3 = Z - yc
dh_H = 0.710
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
rib_depth = 0.123  
rib_length = rib_depth * 4
rib_radius_start = 0.1880*0.5 + t  
rib_radius_peak = 0.1880*0.45;

input = RackSections.Columns.HatRibInput(member_type, section_type, H, D1, D2, D3, A, X, R, t, E, ν, dh_H, dh_D1, dh_D2, de_H, de_D1, de_D2, hole_pitch_H, hole_pitch_D1, hole_pitch_D2, hole_length_H, hole_length_D1, hole_length_D2, rib_depth, rib_length, rib_radius_start, rib_radius_peak)
event_data = JSON3.write(input)
section_outputs = RackSectionsAPI.handle_event(event_data, String[])




member_type = "column"
section_type = "hat with lips and rib"

R = 0.125 + 0.100
t = 0.100
X  = 0.48 + t

using Roots
f(A) = -(atan((X-t)/(0.51 - R * tan((π-A)/2) - (R-t) * tan((π-A)/2))) - π) - A
A = find_zero(f, π/2)
Z = 0.51 - R * tan((π-A)/2) - (R-t) * tan((π-A)/2)

Δ = π - A
T = R * tan(Δ/2)

α = A - π/2
yc = t * tan(α)

H = 3.0
D1 = 1.02 + T
D2 = 1.18 + T
D3 = Z - yc
L = 0.75
dh_H = 0.710
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
rib_depth = 0.123  
rib_length = rib_depth * 4
rib_radius_start = 0.1880*0.5 + t  
rib_radius_peak = 0.1880*0.45;


input = RackSections.Columns.HatLipsRibInput(member_type, section_type, H, D1, D2, D3, A, X, L, R, t, E, ν, dh_H, dh_D1, dh_D2, de_H, de_D1, de_D2, hole_pitch_H, hole_pitch_D1, hole_pitch_D2, hole_length_H, hole_length_D1, hole_length_D2, rib_depth, rib_length, rib_radius_start, rib_radius_peak)
event_data = JSON3.write(input)
section_outputs = RackSectionsAPI.handle_event(event_data, String[])





member_type = "column"
section_type = "hat with lips and trapezoidal rib"

R = 0.125 + 0.100
t = 0.100
X  = 0.48 + t

using Roots
f(A) = -(atan((X-t)/(0.51 - R * tan((π-A)/2) - (R-t) * tan((π-A)/2))) - π) - A
A1 = find_zero(f, π/2)
Z = 0.51 - R * tan((π-A1)/2) - (R-t) * tan((π-A1)/2)

Δ = π - A1
T = R * tan(Δ/2)

α = A1 - π/2
yc = t * tan(α)

H = 3.0
D1 = 1.02 + T
D2 = 1.18 + T
D3 = Z - yc
L = 0.39
dh_H = 0.710
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
wr = 0.25
hr = 0.50
Rr = 0.125 + 0.100
A2 = π/2 + π/4


input = RackSections.Columns.HatLipsTrapezoidalRibInput(member_type, section_type, H, D1, D2, D3, A1, X, L, R, t, E, ν, dh_H, dh_D1, dh_D2, de_H, de_D1, de_D2, hole_pitch_H, hole_pitch_D1, hole_pitch_D2, hole_length_H, hole_length_D1, hole_length_D2, A2, hr, wr, Rr)
event_data = JSON3.write(input)
section_outputs = RackSectionsAPI.handle_event(event_data, String[])


member_type = "column"
section_type = "unistrut with lips in"

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
rib_depth = 0.123  
rib_length = rib_depth * 4
rib_radius_start = 0.1880*0.5 + t  
rib_radius_peak = 0.1880*0.45;

input = RackSections.Columns.UniStrutInput(member_type, section_type, H, D, L1, L2, R, t, E, ν, dh_H, dh_D, de_H, de_D, hole_pitch_H, hole_pitch_D, hole_length_H, hole_length_D, rib_depth, rib_length, rib_radius_start, rib_radius_peak)
event_data = JSON3.write(input)
section_outputs = RackSectionsAPI.handle_event(event_data, String[])


member_type = "column"
section_type = "unistrut with lips out"

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
rib_depth = 0.123  
rib_length = rib_depth * 4
rib_radius_start = 0.1880*0.5 + t  
rib_radius_peak = 0.1880*0.45;


inputs = RackSections.Columns.UniStrutInput(member_type, section_type, H, D, L1, L2, R, t, E, ν, dh_H, dh_D, de_H, de_D, hole_pitch_H, hole_pitch_D, hole_length_H, hole_length_D, rib_depth, rib_length, rib_radius_start, rib_radius_peak)
event_data = JSON3.write(input)
section_outputs = RackSectionsAPI.handle_event(event_data, String[])


