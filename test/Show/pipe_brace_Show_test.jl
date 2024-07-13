

using  RackSections, RackSectionsAPI


E = 29500.0
ν = 0.30


D = 3.0
t = 0.100

input = RackSections.Braces.PipeInput(D, t, E, ν);
section = RackSections.Braces.pipe(input);


all_figures_IO, all_figures, figure_labels = RackSectionsAPI.Show.pipe_brace(section) 

