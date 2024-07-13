using RackSections, RackSectionsAPI

E = 29500.0
ν = 0.30


H = 3.0 
D = 1.5
L = 0.75
R = 0.125 + 0.100
t = 0.100

input = RackSections.Braces.CeeLipsBraceInput(H, D, L, R, t, E, ν)
section = RackSections.Braces.cee_with_lips_brace(input);


all_figures_IO, all_figures, figure_labels = RackSectionsAPI.Show.cee_with_lips_brace(section) 

