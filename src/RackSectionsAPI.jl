module RackSectionsAPI


using StructTypes, RackSections, JSON3, Serialization, AWS, AWSS3, CUFSM

include("MATv5.jl")
using .MATv5


struct Inputs

  member_type::String
  section_type::String
  section_info
  section_details

  create_output_binary::Bool 
  CUFSM_figure_files_bucket_name::String

  create_CUFSM_MAT_files::Bool
  CUFSM_MAT_files_bucket_name::String


end




#CUFSM model file in MATLAB format, written in memory. Same variables as CUFSM.Export.to_MAT, but as a
#Level 5 MAT-file (MATv5.jl) instead of v7.3, so the image does not need MAT.jl and its HDF5/MPI libraries.
function save_MAT_file_to_IO(model)

  lengths = collect(model.lengths)

  m_all = Matrix{Any}(undef, 1, length(lengths))
  fill!(m_all, 1)

  variables = Dict{String, Any}(
    "BC" => "S-S",
    "clas" => Matrix{Float64}(undef, 0, 0),
    "constraints" => 0,
    "curve" => Matrix{Float64}(undef, 0, 0),
    "elem" => model.elem,
    "GBTcon" => Dict{String, Any}("local"=>0.0, "ospace"=>1.0, "other"=>0.0, "couple"=>1.0, "orth"=>2.0, "dist"=>0.0, "glob"=>0.0),
    "lengths" => reshape(lengths, 1, :),   #1 x n row, as CUFSM saves it
    "m_all" => m_all,
    "node" => model.node,
    "prop" => model.prop,
    "shapes" => Matrix{Float64}(undef, 0, 0),
    "springs" => 0)

  io = IOBuffer()
  matwrite_v5(io, variables)

  return take!(io)

end

function get_CUFSM_MAT_IO(section)

  field_list = fieldnames(typeof(section))

  all_MAT_files_IO = Vector{Vector{UInt8}}(undef, 0)
  all_MAT_filenames = Vector{String}(undef, 0)
  for i in eachindex(field_list)
      if occursin("buckling", String(field_list[i]))
          push!(all_MAT_files_IO, save_MAT_file_to_IO(getfield(section, field_list[i])))
          push!(all_MAT_filenames, String(field_list[i]) * ".mat")
      end
  end

  return all_MAT_files_IO, all_MAT_filenames

end




function perform_calculation(event_data)

  input = JSON3.read(event_data)
  # input = JSON.parse(event_data, Inputs)

  println(input.member_type)
  println(input.section_type)

  if input.member_type == "beam"
    if input.section_type == "step_beam"
      
      section_details = StructTypes.constructfrom(RackSections.Beams.StepBeamInput, input.section_details)
      properties = RackSections.Beams.step_beam(section_details)

    elseif input.section_type == "angled_step_beam"
      
      section_details = StructTypes.constructfrom(RackSections.Beams.AngledStepBeamInput, input.section_details)
      properties = RackSections.Beams.angled_step_beam(section_details)

    else
      throw(ArgumentError("Unknown beam section_type \"$(input.section_type)\". Valid: step_beam, angled_step_beam."))
    end
  elseif input.member_type == "column"
    if input.section_type == "closed_tube"

      section_details = StructTypes.constructfrom(RackSections.Columns.RectangularTubeInput, input.section_details)
      properties = RackSections.Columns.rectangular_tube(section_details)
  
    elseif input.section_type == "cee_with_lips"
      
      section_details = StructTypes.constructfrom(RackSections.Columns.CeeLipsInput, input.section_details)
      properties = RackSections.Columns.cee_with_lips(section_details)
  
    elseif input.section_type == "cee_with_lips_and_rib"
      
      section_details = StructTypes.constructfrom(RackSections.Columns.CeeLipsRibInput, input.section_details)
      properties = RackSections.Columns.cee_with_lips_rib(section_details)
 
    elseif input.section_type == "hat"
      
      section_details = StructTypes.constructfrom(RackSections.Columns.HatInput, input.section_details)
      properties = RackSections.Columns.hat(section_details)

    elseif input.section_type == "hat_with_rib"
      
      section_details = StructTypes.constructfrom(RackSections.Columns.HatRibInput, input.section_details)
      properties = RackSections.Columns.hat_with_rib(section_details)

    elseif input.section_type == "hat_with_lips"
      
      section_details = StructTypes.constructfrom(RackSections.Columns.HatLipsInput, input.section_details)
      properties = RackSections.Columns.hat_with_lips(section_details)
 
    elseif input.section_type == "hat_with_lips_and_rib"

      section_details = StructTypes.constructfrom(RackSections.Columns.HatLipsRibInput, input.section_details)
      properties = RackSections.Columns.hat_with_lips_rib(section_details)

    elseif input.section_type == "hat_with_lips_and_trapezoidal_rib"
      
      section_details = StructTypes.constructfrom(RackSections.Columns.HatLipsTrapezoidalRibInput, input.section_details)
      properties = RackSections.Columns.hat_with_lips_trapezoidal_rib(section_details)

    elseif input.section_type == "unistrut_in_with_rib"
      
      section_details = StructTypes.constructfrom(RackSections.Columns.UniStrutRibInput, input.section_details)
      properties = RackSections.Columns.unistrut_in_with_rib(section_details)

    elseif input.section_type == "unistrut_in"
      
      section_details = StructTypes.constructfrom(RackSections.Columns.UniStrutInput, input.section_details)
      properties = RackSections.Columns.unistrut_in(section_details)

    elseif input.section_type == "unistrut_out"
      
      section_details = StructTypes.constructfrom(RackSections.Columns.UniStrutInput, input.section_details)
      properties = RackSections.Columns.unistrut_out(section_details)

    elseif input.section_type == "unistrut_out_with_rib"
      
      section_details = StructTypes.constructfrom(RackSections.Columns.UniStrutRibInput, input.section_details)
      properties = RackSections.Columns.unistrut_out_with_rib(section_details)

    else
      throw(ArgumentError("Unknown column section_type \"$(input.section_type)\". Valid: closed_tube, cee_with_lips, cee_with_lips_and_rib, hat, hat_with_rib, hat_with_lips, hat_with_lips_and_rib, hat_with_lips_and_trapezoidal_rib, unistrut_in, unistrut_in_with_rib, unistrut_out, unistrut_out_with_rib."))
    end
  elseif input.member_type == "brace"
    if input.section_type == "cee_with_lips"  
     
      section_details = StructTypes.constructfrom(RackSections.Braces.CeeLipsBraceInput, input.section_details)
      properties = RackSections.Braces.cee_with_lips_brace(section_details)
 
    elseif input.section_type == "cee"
     
      section_details = StructTypes.constructfrom(RackSections.Braces.CeeInput, input.section_details)
      properties = RackSections.Braces.cee(section_details)
  
    elseif input.section_type == "pipe"
      
      section_details = StructTypes.constructfrom(RackSections.Braces.PipeInput, input.section_details)
      properties = RackSections.Braces.pipe(section_details)
  
    elseif input.section_type == "formed_angle"
     
      section_details = StructTypes.constructfrom(RackSections.Braces.AngleInput, input.section_details)
      properties = RackSections.Braces.angle(section_details)
   
    elseif input.section_type == "closed_tube"
      
      section_details = StructTypes.constructfrom(RackSections.Braces.RectangularTubeBraceInput, input.section_details)
      properties = RackSections.Braces.rectangular_tube_brace(section_details)

    else
      throw(ArgumentError("Unknown brace section_type \"$(input.section_type)\". Valid: cee_with_lips, cee, pipe, formed_angle, closed_tube."))
    end
  else
    throw(ArgumentError("Unknown member_type \"$(input.member_type)\". Valid: beam, column, brace."))
  end

  section_outputs = JSON3.write(properties)
  #section_outputs = JSON.json(properties)

  if (input.create_output_binary == true || input.create_CUFSM_MAT_files == true)

    aws = global_aws_config(; region="us-east-2")

  end

  if input.create_output_binary == true 

    io = IOBuffer()
    serialize(io, properties)
    s3_put(aws, input.CUFSM_figure_files_bucket_name,"properties.jlb", take!(io))

  end


  if input.create_CUFSM_MAT_files == true

    all_MAT_files_IO, all_MAT_filenames = get_CUFSM_MAT_IO(properties)

    for i in eachindex(all_MAT_files_IO)
      s3_put(aws, input.CUFSM_MAT_files_bucket_name, all_MAT_filenames[i], all_MAT_files_IO[i])
    end

  end

  return section_outputs

end

# Define a handler function that is called by the lambda runtime
function handle_event(event_data, headers)
  @info "Handling request" event_data headers
  section_outputs = perform_calculation(event_data)
  return section_outputs
end




end # module RackSectionsAPI

