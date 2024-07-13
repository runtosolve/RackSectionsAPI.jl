using RackSections, RackSectionsAPI

E = 29500.0
ν = 0.30


H = 2.0
D = 2.0
R = 0.125 + 1/8
t = 1/8


input = RackSections.Braces.AngleInput(H, D, R, t, E, ν)
section = RackSections.Braces.angle(input);


all_figures_IO, all_figures, figure_labels = RackSectionsAPI.Show.angle_brace(section) 

