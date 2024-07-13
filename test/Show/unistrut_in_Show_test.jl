using RackSections, RackSectionsAPI

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
rib_depth = 0.123  
rib_length = rib_depth * 4
rib_radius_start = 0.1880*0.5 + t  #outside radius
rib_radius_peak = 0.1880*0.45;     #inside radius


input = RackSections.Columns.UniStrutInput(H, D, L1, L2, R, t, E, ν, dh_H, dh_D, de_H, de_D, hole_pitch_H, hole_pitch_D, hole_length_H, hole_length_D, rib_depth, rib_length, rib_radius_start, rib_radius_peak)
section = RackSections.Columns.unistrut_in(input);


all_figures_IO, all_figures, figure_labels = RackSectionsAPI.Show.unistrut_column(section) 

