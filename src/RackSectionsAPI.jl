module RackSectionsAPI


using StructTypes, RackSections, JSON3, Serialization, AWS, AWSS3


struct Inputs

  member_type::String
  section_type::String
  section_details

  create_output_binary::Bool 
  CUFSM_figure_files_bucket_name::String

  create_CUFSM_MAT_files::Bool
  CUFSM_MAT_files_bucket_name::String


end




function save_MAT_file_to_IO(model, file_path, file_name)

  elem = model.elem
  lengths = model.lengths
  node = model.node
  prop = model.prop
  CUFSM.Export.to_MAT(file_path, file_name, elem, lengths, node, prop)

  io = IOBuffer()

  ReadWriteFind.read_to_io(joinpath(file_path, file_name), io)

  return io.data

end

function get_CUFSM_MAT_IO(section)

  file_path = "/tmp/"

  field_list = fieldnames(typeof(section))

  all_MAT_files_IO = Vector{Vector{UInt8}}(undef, 0)
  all_MAT_filenames = Vector{String}(undef, 0)
  for i in eachindex(field_list)
      if occursin("buckling", String(field_list[i]))
          file_name = String(field_list[i])
          push!(all_MAT_files_IO, save_MAT_file_to_IO(getfield(section, field_list[i]), file_path, file_name))
          push!(all_MAT_filenames, String(field_list[i]) * ".mat")
      end
  end

  return all_MAT_files_IO, all_MAT_filenames

end




function perform_calculation(event_data)

  input = JSON3.read(event_data)

  if input.member_type == "beam"
    if input.section_type == "step_beam"
      
      section_details = StructTypes.constructfrom(RackSections.Beams.StepBeamInput, input.section_details)
      properties = RackSections.Beams.step_beam(section_details)

    elseif input.section_type == "angled_step_beam"
      
      section_details = StructTypes.constructfrom(RackSections.Beams.AngledStepBeamInput, input.section_details)
      properties = RackSections.Beams.angled_step_beam(section_details)
 
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
 
    elseif input.section_type == "hat_with_rib"
      
      section_details = StructTypes.constructfrom(RackSections.Columns.HatRibInput, input.section_details)
      properties = RackSections.Columns.hat_with_rib(section_details)
 
    elseif input.section_type == "hat_with_lips_and_rib"

      section_details = StructTypes.constructfrom(RackSections.Columns.HatLipsRibInput, input.section_details)
      properties = RackSections.Columns.hat_with_lips_rib(section_details)

    elseif input.section_type == "hat_with_lips_and_trapezoidal_rib"
      
      section_details = StructTypes.constructfrom(RackSections.Columns.HatLipsTrapezoidalRibInput, input.section_details)
      properties = RackSections.Columns.hat_with_lips_trapezoidal_rib(section_details)

    elseif input.section_type == "unistrut_with_lips_in"
      
      section_details = StructTypes.constructfrom(RackSections.Columns.UniStrutInput, input.section_details)
      properties = RackSections.Columns.unistrut_in(section_details)

    elseif input.section_type == "unistrut_with_lips_out"
      
      section_details = StructTypes.constructfrom(RackSections.Columns.UniStrutInput, input.section_details)
      properties = RackSections.Columns.unistrut_out(section_details)
   
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
   
    end
  end

  section_outputs = JSON3.write(properties)

  if input.create_output_binary == true

    aws = global_aws_config(; region="us-east-2")

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

