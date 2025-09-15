
function write_input_output_jsons(file_path, member_type, section_type, section_info, input, output)

    file_name = member_type * "_" * section_type * "_" * section_info * "_input.json"
    open(joinpath(file_path, file_name), "w") do f
        JSON3.pretty(f, JSON3.write(input))
    end


    file_name = member_type * "_" * section_type * "_" * section_info * "_output.json"
    open(joinpath(file_path, file_name), "w") do f
        JSON3.pretty(f, output)
    end

end
