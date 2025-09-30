
function write_input_output_jsons(file_path, member_type, section_type, section_info, input, output)

    if !isempty(section_info)

        file_name = member_type * "_" * section_type * "_" * section_info * "_input.json"

    else

        file_name = member_type * "_" * section_type * "_input.json"

    end

        open(joinpath(file_path, file_name), "w") do f
            JSON3.pretty(f, JSON3.write(input))
        end



    if !isempty(section_info)

        file_name = member_type * "_" * section_type * "_" * section_info * "_output.json"

    else 

        file_name = member_type * "_" * section_type * "_output.json"

    end

    open(joinpath(file_path, file_name), "w") do f
        JSON3.pretty(f, output)
    end

end
