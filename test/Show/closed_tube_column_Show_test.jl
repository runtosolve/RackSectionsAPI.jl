

using  RackSections, RackSectionsAPI


E = 29500.0
ν = 0.30


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

input = RackSections.Columns.RectangularTubeInput(H, D, R, t, E, ν, dh_H, dh_D, de_H, de_D, hole_pitch_H, hole_pitch_D, hole_length_H, hole_length_D)
section = RackSections.Columns.rectangular_tube(input);


all_figures_IO, all_figures, figure_labels = RackSectionsAPI.Show.closed_tube_column(section) 

