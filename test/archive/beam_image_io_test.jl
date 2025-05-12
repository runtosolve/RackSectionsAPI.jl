using  JSON3, RackSections, StructTypes, CUFSM, Base64

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

input = RackSections.Beams.StepBeamInput(H, D, W, L, R, t, E, ν)
section = RackSections.Beams.step_beam(input)

deformation_scale = (0.5, 0.5)
drawing_scale = 100.0
eig = 1
ax, figure = CUFSM.Show.minimum_mode_shape(section.local_buckling_P, eig, fill(t, length(section.geometry.x)), deformation_scale, drawing_scale)


io = IOBuffer()
show(io, MIME"image/png"(), figure)

#S3.put_object(string, string key, dictionary(body, io.data))

cdm = :transparent