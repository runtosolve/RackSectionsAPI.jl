using RackSections, RackSectionsAPI

E = 29500.0
ν = 0.30


H = 3.0 
D = 1.5
R = 0.125 + 0.100
t = 0.100

input = RackSections.Braces.CeeInput(H, D, R, t, E, ν)
section = RackSections.Braces.cee(input);


all_figures_IO, all_figures, figure_labels = RackSectionsAPI.Show.cee_brace(section) 

