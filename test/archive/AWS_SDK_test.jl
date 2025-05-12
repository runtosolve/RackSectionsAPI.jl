
using RackSections, JSON3, StructTypes, RackSectionsAPI, AWS



E = 29500.0
ν = 0.30

#' ### Inputs

member_type = "beam"
section_type = "step beam"
H = 4.0 
D = 3.0
W = 2.0
L = 1.0
R = 0.125 + 0.100
t = 0.100

section_inputs = RackSections.Beams.StepBeamInput(H, D, W, L, R, t, E, ν)

section_inputs_json = JSON3.write(section_inputs)

api_inputs = RackSectionsAPI.Inputs(member_type, section_type, section_inputs_json, true, true)

section_properties = RackSections.Beams.step_beam(section_inputs)

if api_inputs.create_image_files == true

    all_figures_IO, all_figures, figure_labels = RackSectionsAPI.Show.step_beam(section_properties)    

end

using AWS: @service
@service S3



bucket = "epiq-cufsm-files"
# key = "moen_test_2"

# test = ["Cris Moen!!!!"]
# params = Dict([("Body", test)])
# S3.put_object(bucket, key, params)


key = "moen_test_4"
test = string(all_figures_IO[1][1:2])
params = Dict([("Body", test)])
S3.put_object(bucket, key, params)


key = "moen_test_5"
test = all_figures_IO[1][1]
params = Dict([("Body", test)])
S3.put_object(bucket, key, params)



epiq_dir = S3.list_objects("epiq-cufsm-files")

# params = Dict("Body" => all_figures_IO[1])

# params = Dict("Body" => test)





#AWSS3.jl....





