module RackSectionsAPI

using StructTypes, RackSections, JSON3


struct Options

  create_MAT_file::Boolean
  create_image_files::Boolean 
  
end


struct Inputs

  options::Options
  input::String

end


struct Outputs

  properties::
  MAT_file::String
  image_files::Vector{Vector{{UInt8}}}

end


StructTypes.StructType(::Type{RackSections.Beams.StepBeamInput}) = StructTypes.Struct()
StructTypes.StructType(::Type{RackSections.Beams.AngledStepBeamInput}) = StructTypes.Struct()

StructTypes.StructType(::Type{RackSections.Columns.RectangularTubeInput}) = StructTypes.Struct()
StructTypes.StructType(::Type{RackSections.Columns.CeeLipsInput}) = StructTypes.Struct()
StructTypes.StructType(::Type{RackSections.Columns.CeeLipsRibInput}) = StructTypes.Struct()
StructTypes.StructType(::Type{RackSections.Columns.HatRibInput}) = StructTypes.Struct()
StructTypes.StructType(::Type{RackSections.Columns.HatLipsRibInput}) = StructTypes.Struct()
StructTypes.StructType(::Type{RackSections.Columns.HatLipsTrapezoidalRibInput}) = StructTypes.Struct()
StructTypes.StructType(::Type{RackSections.Columns.UniStrutInput}) = StructTypes.Struct()

StructTypes.StructType(::Type{RackSections.Braces.CeeLipsBraceInput}) = StructTypes.Struct()
StructTypes.StructType(::Type{RackSections.Braces.CeeInput}) = StructTypes.Struct()
StructTypes.StructType(::Type{RackSections.Braces.PipeInput}) = StructTypes.Struct()
StructTypes.StructType(::Type{RackSections.Braces.AngleInput}) = StructTypes.Struct()
StructTypes.StructType(::Type{RackSections.Braces.RectangularTubeBraceInput}) = StructTypes.Struct()

function perform_calculation(event_data)

  input = JSON3.read(event_data)

  if input.member_type == "beam"
    if input.section_type == "step beam"
      section_input = JSON3.read(event_data, RackSections.Beams.StepBeamInput)
      properties = RackSections.Beams.step_beam(section_input)
    elseif input.section_type == "angled step beam"
      section_input = JSON3.read(event_data, RackSections.Beams.AngledStepBeamInput)
      properties = RackSections.Beams.angled_step_beam(section_input)
    end
  elseif input.member_type == "column"
    if input.section_type == "closed tube"
      section_input = JSON3.read(event_data, RackSections.Columns.RectangularTubeInput)
      properties = RackSections.Columns.rectangular_tube(section_input)
    elseif input.section_type == "cee with lips"
      section_input = JSON3.read(event_data, RackSections.Columns.CeeLipsInput)
      properties = RackSections.Columns.cee_with_lips(section_input)
    elseif input.section_type == "cee with lips and rib"
      section_input = JSON3.read(event_data, RackSections.Columns.CeeLipsRibInput)
      properties = RackSections.Columns.cee_with_lips_rib(section_input)
    elseif input.section_type == "hat with rib"
      section_input = JSON3.read(event_data, RackSections.Columns.HatRibInput)
      properties = RackSections.Columns.hat_with_rib(section_input)
    elseif input.section_type == "hat with lips and rib"
      section_input = JSON3.read(event_data, RackSections.Columns.HatLipsRibInput)
      properties = RackSections.Columns.hat_with_lips_rib(section_input)
    elseif input.section_type == "hat with lips and trapezoidal rib"
      section_input = JSON3.read(event_data, RackSections.Columns.HatLipsTrapezoidalRibInput)
      properties = RackSections.Columns.hat_with_lips_trapezoidal_rib(section_input)
    elseif input.section_type == "unistrut with lips in"
      section_input = JSON3.read(event_data, RackSections.Columns.UniStrutInput)
      properties = RackSections.Columns.unistrut_in(section_input)
    elseif input.section_type == "unistrut with lips out"
      section_input = JSON3.read(event_data, RackSections.Columns.UniStrutInput)
      properties = RackSections.Columns.unistrut_out(section_input)
    end
  elseif input.member_type == "brace"
    if input.section_type == "cee with lips"  
      section_input = JSON3.read(event_data, RackSections.Braces.CeeLipsBraceInput)
      properties = RackSections.Braces.cee_with_lips_brace(section_input)
    elseif input.section_type == "cee"
      section_input = JSON3.read(event_data, RackSections.Braces.CeeInput)
      properties = RackSections.Braces.cee(section_input)
    elseif input.section_type == "pipe"
      section_input = JSON3.read(event_data, RackSections.Braces.PipeInput)
      properties = RackSections.Braces.pipe(section_input)
    elseif input.section_type == "formed angle"
      section_input = JSON3.read(event_data, RackSections.Braces.AngleInput)
      properties = RackSections.Braces.angle(section_input)
    elseif input.section_type == "closed tube"
      section_input = JSON3.read(event_data, RackSections.Braces.RectangularTubeBraceInput)
      properties = RackSections.Braces.rectangular_tube_brace(section_input)
    end
  end

  #if , send to S3
  #mat file also...

  section_outputs = JSON3.write(properties)
  
  return section_outputs
end

# Define a handler function that is called by the lambda runtime
function handle_event(event_data, headers)
  @info "Handling request" event_data headers
  section_outputs = perform_calculation(event_data)
  return section_outputs
end

end # module RackSectionsAPI

