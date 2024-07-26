module RackSectionsAPI

using StructTypes, RackSections, JSON3, AWS, AWSS3

export Show
include("Show.jl")
using .Show


struct Inputs

  member_type::String
  section_type::String
  section_details::String
  create_MAT_file::Bool
  create_image_files::Bool

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


function generate_figures(f::Function, properties)

  all_figures_IO, all_figures, figure_labels = f(properties)

end

function perform_calculation(event_data)

  input = JSON3.read(event_data)

  if input.member_type == "beam"
    if input.section_type == "step beam"
      section_input = JSON3.read(input.section_details, RackSections.Beams.StepBeamInput)
      properties = RackSections.Beams.step_beam(section_input)
      if input.create_image_files == true
        all_figures_IO, all_figures, figure_labels = Show.step_beam(properties)
      end
    elseif input.section_type == "angled step beam"
      section_input = JSON3.read(input.section_details, RackSections.Beams.AngledStepBeamInput)
      properties = RackSections.Beams.angled_step_beam(section_input)
      if input.create_image_files == true
        all_figures_IO, all_figures, figure_labels = Show.angled_step_beam(properties)
      end
    end
  elseif input.member_type == "column"
    if input.section_type == "closed tube"
      section_input = JSON3.read(input.section_details, RackSections.Columns.RectangularTubeInput)
      properties = RackSections.Columns.rectangular_tube(section_input)
      if input.create_image_files == true
        all_figures_IO, all_figures, figure_labels = Show.rectangular_tube(properties)
      end
    elseif input.section_type == "cee with lips"
      section_input = JSON3.read(input.section_details, RackSections.Columns.CeeLipsInput)
      properties = RackSections.Columns.cee_with_lips(section_input)
      if input.create_image_files == true
        all_figures_IO, all_figures, figure_labels = Show.cee_with_lips_column(properties)
      end
    elseif input.section_type == "cee with lips and rib"
      section_input = JSON3.read(input.section_details, RackSections.Columns.CeeLipsRibInput)
      properties = RackSections.Columns.cee_with_lips_rib(section_input)
      if input.create_image_files == true
        all_figures_IO, all_figures, figure_labels = Show.cee_with_lips_column(properties)
      end
    elseif input.section_type == "hat with rib"
      section_input = JSON3.read(input.section_details, RackSections.Columns.HatRibInput)
      properties = RackSections.Columns.hat_with_rib(section_input)
      if input.create_image_files == true
        all_figures_IO, all_figures, figure_labels = Show.hat_with_rib_column(properties)
      end
    elseif input.section_type == "hat with lips and rib"
      section_input = JSON3.read(input.section_details, RackSections.Columns.HatLipsRibInput)
      properties = RackSections.Columns.hat_with_lips_rib(section_input)
      if input.create_image_files == true
        all_figures_IO, all_figures, figure_labels = Show.hat_with_rib_column(properties)
      end
    elseif input.section_type == "hat with lips and trapezoidal rib"
      section_input = JSON3.read(input.section_details, RackSections.Columns.HatLipsTrapezoidalRibInput)
      properties = RackSections.Columns.hat_with_lips_trapezoidal_rib(section_input)
      if input.create_image_files == true
        all_figures_IO, all_figures, figure_labels = Show.hat_with_rib_column(properties)
      end
    elseif input.section_type == "unistrut with lips in"
      section_input = JSON3.read(input.section_details, RackSections.Columns.UniStrutInput)
      properties = RackSections.Columns.unistrut_in(section_input)
      if input.create_image_files == true
        all_figures_IO, all_figures, figure_labels = Show.unistrut_column(properties)
      end
    elseif input.section_type == "unistrut with lips out"
      section_input = JSON3.read(input.section_details, RackSections.Columns.UniStrutInput)
      properties = RackSections.Columns.unistrut_out(section_input)
      if input.create_image_files == true
        all_figures_IO, all_figures, figure_labels = Show.unistrut_column(properties)
      end
    end
  elseif input.member_type == "brace"
    if input.section_type == "cee with lips"  
      section_input = JSON3.read(input.section_details, RackSections.Braces.CeeLipsBraceInput)
      properties = RackSections.Braces.cee_with_lips_brace(section_input)
      if input.create_image_files == true
        all_figures_IO, all_figures, figure_labels = Show.cee_with_lips_brace(properties)
      end
    elseif input.section_type == "cee"
      section_input = JSON3.read(input.section_details, RackSections.Braces.CeeInput)
      properties = RackSections.Braces.cee(section_input)
      if input.create_image_files == true
        all_figures_IO, all_figures, figure_labels = Show.cee_brace(properties)
      end
    elseif input.section_type == "pipe"
      section_input = JSON3.read(input.section_details, RackSections.Braces.PipeInput)
      properties = RackSections.Braces.pipe(section_input)
      if input.create_image_files == true
        all_figures_IO, all_figures, figure_labels = Show.pipe_brace(properties)
      end
    elseif input.section_type == "formed angle"
      section_input = JSON3.read(input.section_details, RackSections.Braces.AngleInput)
      properties = RackSections.Braces.angle(section_input)
      if input.create_image_files == true
        all_figures_IO, all_figures, figure_labels = Show.angle_brace(properties)
      end
    elseif input.section_type == "closed tube"
      section_input = JSON3.read(input.section_details, RackSections.Braces.RectangularTubeBraceInput)
      properties = RackSections.Braces.rectangular_tube_brace(section_input)
      if input.create_image_files == true
        all_figures_IO, all_figures, figure_labels = Show.rectangular_tube_brace(properties)
      end
    end
  end

  section_outputs = JSON3.write(properties)

  if input.create_image_files == true
    aws = global_aws_config(; region="us-east-2")
    bucket = "epiq-cufsm-files"

    for i in eachindex(all_figures_IO)
      s3_put(aws, bucket, figure_labels[i] * ".png", all_figures_IO[i])
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

