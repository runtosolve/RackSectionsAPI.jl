"""
Minimal writer for MATLAB Level 5 MAT-files (the format MATLAB's `save -v7` uses, without compression).

Supports what the CUFSM model files need: real Float64 arrays (including empty), Int64 scalars and arrays,
strings, structs (`AbstractDict{String}`, written as a 1x1 struct), and cell arrays (`AbstractArray{Any}`).
This replaces MAT.jl, whose v7.3 (HDF5) writer pulled HDF5, MPI and AWS C libraries into the image.

Format reference: MathWorks, "MAT-File Format" (matfile_format.pdf), Level 5 MAT-files.
"""
module MATv5

export matwrite_v5

#data types
const miINT8 = UInt32(1)
const miUINT16 = UInt32(4)
const miINT32 = UInt32(5)
const miUINT32 = UInt32(6)
const miDOUBLE = UInt32(9)
const miINT64 = UInt32(12)
const miMATRIX = UInt32(14)

#array classes
const mxCELL_CLASS = UInt32(1)
const mxSTRUCT_CLASS = UInt32(2)
const mxCHAR_CLASS = UInt32(4)
const mxDOUBLE_CLASS = UInt32(6)
const mxINT64_CLASS = UInt32(14)

padding(n) = (8 - n % 8) % 8

#a data element: 8-byte tag (type, byte count) followed by the data, padded to an 8-byte boundary
function write_element(io::IO, type::UInt32, data::Vector{UInt8})
    write(io, htol(type), htol(UInt32(length(data))))
    write(io, data)
    write(io, zeros(UInt8, padding(length(data))))
end

to_bytes(x::AbstractArray{T}) where {T<:Union{Float64,Int64,Int32,UInt16,UInt32}} = Vector{UInt8}(reinterpret(UInt8, htol.(vec(collect(x)))))

#the body of a miMATRIX element: array flags, dimensions, name, then the class-specific data
function matrix_body(class::UInt32, dims, name::AbstractString, write_data)
    io = IOBuffer()
    write_element(io, miUINT32, to_bytes(UInt32[class, 0]))
    write_element(io, miINT32, to_bytes(Int32.(collect(dims))))
    write_element(io, miINT8, Vector{UInt8}(codeunits(name)))
    write_data(io)
    return take!(io)
end

matrix_dims(x::AbstractVector) = (length(x), 1)
matrix_dims(x::AbstractArray) = size(x)
matrix_dims(x::Number) = (1, 1)

matrix_body(name, x::Real) = matrix_body(name, [Float64(x)])
matrix_body(name, x::Int64) = matrix_body(name, [x])

matrix_body(name, x::AbstractArray{<:AbstractFloat}) =
    matrix_body(mxDOUBLE_CLASS, matrix_dims(x), name, io -> write_element(io, miDOUBLE, to_bytes(Float64.(x))))

matrix_body(name, x::AbstractArray{Int64}) =
    matrix_body(mxINT64_CLASS, matrix_dims(x), name, io -> write_element(io, miINT64, to_bytes(x)))

function matrix_body(name, x::AbstractString)
    chars = UInt16[UInt16(c) for c in x]   #MATLAB char arrays are UTF-16 code units; CUFSM strings are ASCII
    matrix_body(mxCHAR_CLASS, (1, length(chars)), name, io -> write_element(io, miUINT16, to_bytes(chars)))
end

function matrix_body(name, x::AbstractDict{<:AbstractString})
    fields = sort!(collect(keys(x)))
    name_length = maximum(ncodeunits, fields; init=0) + 1
    (name_length <= 64) || throw(ArgumentError("MATv5: struct field names must be at most 63 characters."))
    matrix_body(mxSTRUCT_CLASS, (1, 1), name, function (io)
        #field name length uses the small data element format (2-byte type, 2-byte count, 4 bytes of data)
        write(io, htol(UInt16(miINT32)), htol(UInt16(4)), htol(Int32(name_length)))
        names = zeros(UInt8, name_length * length(fields))
        for (i, f) in enumerate(fields)
            names[(i-1)*name_length .+ (1:ncodeunits(f))] .= codeunits(f)
        end
        write_element(io, miINT8, names)
        for f in fields
            write_element(io, miMATRIX, matrix_body("", x[f]))
        end
    end)
end

function matrix_body(name, x::AbstractArray{Any})
    matrix_body(mxCELL_CLASS, matrix_dims(x), name, function (io)
        for v in vec(x)   #column-major order
            write_element(io, miMATRIX, matrix_body("", v))
        end
    end)
end

"""
    matwrite_v5(io::IO, variables::AbstractDict{<:AbstractString})

Write `variables` (name => value) to `io` as a Level 5 MAT-file.
"""
function matwrite_v5(io::IO, variables::AbstractDict{<:AbstractString})
    text = rpad("MATLAB 5.0 MAT-file, Platform: Julia, Created by: RackSectionsAPI", 116)
    write(io, codeunits(text))
    write(io, zeros(UInt8, 8))                  #subsystem data offset (unused)
    write(io, htol(UInt16(0x0100)))             #version
    write(io, htol(UInt16(0x4D49)))             #"IM" endian indicator (little-endian file)
    for name in sort!(collect(keys(variables)))
        write_element(io, miMATRIX, matrix_body(name, variables[name]))
    end
    return io
end

end #module
