using RackSections, RackSectionsAPI


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
rib_depth = 0.123  
rib_length = rib_depth * 4
rib_radius_start = 0.1880*0.5 + t  
rib_radius_peak = 0.1880*0.45;

input = RackSections.Columns.HatLipsRibInput(H, D1, D2, D3, A, X, L, R, t, E, ν, dh_H, dh_D1, dh_D2, de_H, de_D1, de_D2, hole_pitch_H, hole_pitch_D1, hole_pitch_D2, hole_length_H, hole_length_D1, hole_length_D2, rib_depth, rib_length, rib_radius_start, rib_radius_peak)
section = RackSections.Columns.hat_with_lips_rib(input);


all_figures_IO, all_figures, figure_labels = RackSectionsAPI.Show.hat_with_rib_column(section) 

