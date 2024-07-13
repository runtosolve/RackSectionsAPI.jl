

using  RackSections, RackSectionsAPI


E = 29500.0
ν = 0.30


H = 3.0 
D = 3.0
L = 0.75
R = 0.125 + 0.100
t = 0.100
input = RackSections.Braces.RectangularTubeBraceInput(H, D, R, t, E, ν);
section = RackSections.Braces.rectangular_tube_brace(input);


all_figures_IO, all_figures, figure_labels = RackSectionsAPI.Show.rectangular_tube_brace(section) 

