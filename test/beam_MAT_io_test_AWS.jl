using  JSON3, RackSections, StructTypes, RackSectionsAPI, CUFSM, Base64


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

section = RackSections.Beams.step_beam(section_inputs)

# input = RackSections.Beams.StepBeamInput(member_type, section_type, H, D, W, L, R, t, E, ν)
# section = RackSections.Beams.step_beam(input)

using AWS, AWSS3, FilePathsBase


file_path = S3Path("s3://epiq-cufsm-files", config=global_aws_config(; region="us-east-2"));


# file_path = "/Users/crismoen/.julia/dev/RackSectionsAPI/test"
file_name = "CUFSM_beam_julia.mat"

typeof(joinpath(file_path, file_name))

file_path = "/tmp/"

elem = section.local_buckling_P.elem
lengths = section.local_buckling_P.lengths
node = section.local_buckling_P.node
prop = section.local_buckling_P.prop
CUFSM.Export.to_MAT(file_path, file_name, elem, lengths, node, prop)

#/tmp
read("/Users/crismoen/.julia/dev/RackSectionsAPI/test/CUFSM_beam_julia.mat", String)

#value of S3.body ....

