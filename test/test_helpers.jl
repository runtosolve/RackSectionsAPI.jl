
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



#Hat sections take W (clear depth between the step flanges) instead of D2.
#Convert the D2-based example dimensions used in these tests to the equivalent W.
function hat_W_from_D2(H, D, D1, D2, A, t)

    A_rad = deg2rad(A)
    X = (D - D2 - D1 + t * cos(A_rad / 2)) * tan(π - A_rad) + t   #step height, out-to-out

    return H - 2 * X

end
