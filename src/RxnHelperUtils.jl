module RxnHelperUtils

using LightXML, Printf

include("Constants.jl")


export convert2si, get_index, parse_composition,
    massfrac_to_molefrac!, massfrac_to_molefrac, molefrac_to_massfrac!, average_molwt, density,
    get_collection_from_xml, get_value_from_xml, get_text_from_xml, get_molefraction_from_xml,
    create_header, write_to_file, get_path, output_file, create_csv_header, write_csv

cf = Dict("M"=>1,"CM"=>0.01,"KJ/MOLE"=>1000, "KJ/MOL"=>1000, "CAL/MOLE"=>4.184, "CAL/MOL"=>4.184, "KCAL/MOLE"=>4184, 
    "JOULES/MOLE"=>1, "EVOLTS"=>96491.5)

"""
Function for converting any unit to SI unit.
# Usage:    
convert2si(u::String)
    The function will return the corresponding value in SI units 
"""    
convert2si(u::String) = cf[strip(uppercase(u))]


"""
get_index(sp,ig)
Get the index of species in the gasphase limits
#Usage
get_index(sp,ig)
-   sp::String : species name
-  sp_list::Array{String,1}  : Array of species names 
"""
function get_index(sp::String,splist::Array{String,1})
    if uppercase(strip(sp)) in splist
        return findfirst(x-> x == uppercase(strip(sp)),splist)
    else
        throw(ErrorException("species $sp not present in $splist"))
    end
end

"""
function for constructing relative path to a file
#Usage:    
get_path(path::String, file_name::String)
"""
function get_path(path::String, file_name::String)
    if Sys.isapple() || Sys.islinux()
        dirs = split(path,"/")        
    elseif Sys.iswindows()
        dirs = split(path,"\\")
    end
    push!(dirs,file_name)
    joinpath(dirs)
end

"""
Function for creating path to the output file
# Usage 
output_file(input_file::String, output_file::String)
-   input_file::String : input file including the path specification
-   output_file::String : output file including path specification

The output file will be placed in the same location as that of the 
input file. This function finds the location of the input file, 
constructs the path based on the input file location 
"""
function output_file(input_file::String, output_file::String)
    if Sys.isapple() || Sys.islinux()
        dirs = split(input_file,"/")        
    elseif Sys.iswindows()
        dirs = split(input_file,"\\")
    end
    pop!(dirs) # removes the input file name 
    push!(dirs,output_file) # adds the output file name
    joinpath(dirs) # constructs the full path
end 

"""
Function to parse the composition string
# Usage:
    parse_composition(composition_data,sp_list)
-   composition_data::String : composition specification String
-   sp_list:Array{String,1}: Array of species names
"""
function parse_composition(composition_data::String, sp_list::Array{String,1})
    species_composition = split(composition_data,",")
    composition = zeros(length(sp_list))
    for sc in species_composition
        species,val = split(sc,"=")
        composition[get_index(String(species), sp_list)] = parse(Float64,val)
    end
    return composition
end

"""
Function to convert massfractions to mole fractions
# Usage:
    massfrac_to_molefrac!(massfracs,mol_wt,molefracs)
-   massfracs::Array{Float64,1} : Vector of massfractions
-   mol_wt::Array{Float64,1} : Vector of molecular weights
-   molefracs::Array{Float64,1} : Vector of molefractions 
"""
function massfrac_to_molefrac!(molefracs::T, massfracs::T, mol_wt::T) where T <: Array{Float64,1}    
    molefracs .= (massfracs ./ mol_wt)/sum(massfracs ./ mol_wt)
end


"""
Function to convert massfractions to mole fractions
# Usage:
massfrac_to_molefrac(massfracs,mol_wt,molefracs)
-   massfracs::Array{Float64,1} : Vector of massfractions
-   mol_wt::Array{Float64,1} : Vector of molecular weights
"""
function massfrac_to_molefrac(massfracs::T,mol_wt::T) where T <: Array{Float64,1}    
    return (massfracs ./ mol_wt)/sum(massfracs ./ mol_wt)
end


"""
Function to convert molefractions to massfractions
# Usage:
    molefrac_to_massfrac!(massfracs,molefracs,mol_wt)
-   molefracs::Array{Float64,1} : Vector of molefractions
-   mol_wt::Array{Float64,1} : Vector of molecular weights
"""
function molefrac_to_massfrac!(massfracs::T, molefracs::T,mol_wt::T) where T <: Array{Float64,1}        
    massfracs .=  (molefracs .* mol_wt)/sum(molefracs .* mol_wt)    
end


"""
Function for calculating the average molecular weight
# Usage:
average_molwt(molfracs,molwt)
-  molfracs::Array{Float64,1} : vector of mole fraction 
-  molwt::Array{Float64,1} :    vector of molecular weights 
"""
average_molwt(molfracs::T,molwt::T) where T = sum(molfracs .* molwt)


"""
Function for the calculation of density 
# Usage
density(avg_molwt, T, p)    
- avg_molwt : average molecular weight
- T : temperature in K 
- p : pressure in Pa 
"""
density(avg_molwt::T1, T::T1, p::T1) where T1 = p*avg_molwt/(R*T)
density(molefrac::Array{T1,1},molwt::Array{T1,1}, T::T1, p::T1) where T1 = p*average_molwt(molefrac,molwt)/(R*T)


"""
Function to get floating point value from an  xml tag
#   Usage:
get_value_from_xml(xmlroot,tag)
-   xmlroot::XMLElement : The xml root node
-   tag::String : name of the tag
The function returns the floating point value contained in the tag
"""
function get_value_from_xml(xmlroot::XMLElement,tag::String)
    tag_node = get_elements_by_tagname(xmlroot,tag)
    if !isempty(tag_node)        
        tag_content = String(content(tag_node[1]))
        return parse(Float64,tag_content)        
    else
        return 1.0
    end
end

"""
Function to get the file path from an xml tag
# Usage:
get_text_from_xml(xmlroot,tag)
-   xmlroot::XMLElement : The xml root node
-   tag::String : name of the tag
The function returns string of file path
"""
function get_text_from_xml(xmlroot::XMLElement,tag::String)
    tag_node = get_elements_by_tagname(xmlroot,tag)
    if !isempty(tag_node) 
        return String(strip(content(tag_node[1])))
    else
        nothing
    end    
end

"""
Function to get vector of strings contained in a tag.
Ideal for getting the species names 
# Usage:
get_collection_from_xml(xmlroot,tag)
-   xmlroot::XMLElement : The xml root node
-   tag::String : name of the tag
The function returns vector of strings. 

"""    
function get_collection_from_xml(xmlroot::XMLElement,tag::String)
    tag_node = get_elements_by_tagname(xmlroot,tag)   
    if is_elementnode(tag_node[1])
        return map(x->String(uppercase(x)),split(content(tag_node[1])))
    else
        throw(error("Unable to find the node $tag in the xmlroot\n"))
    end
end
    
"""
Function to get the mole fractions of species
# Usage:
get_molefraction_from_xml(xmlroot,molwt,gasphase)
-   xmlroot::XMLElement : The xml root node
-   molwt::Array{Float64} :  Vector of molecular weights
"""
function get_molefraction_from_xml(xmlroot::XMLElement, molwt::Array{Float64},gasphase::Array{String,1})
    tag_molefraction = get_elements_by_tagname(xmlroot,"molefractions")
    tag_massfraction = get_elements_by_tagname(xmlroot,"massfractions")
    local mass_fracs = Array{Float64,1}()
    local mole_fracs = Array{Float64,1}()
    if length(tag_massfraction) > 0
        massfraction = content(tag_massfraction[1])
        mass_fracs = parse_composition(massfraction,gasphase)
        mole_fracs = massfrac_to_molefrac(mass_fracs,molwt)
        return mole_fracs
    end    

    if length(tag_molefraction) > 0
        molefraction = content(tag_molefraction[1])
        mole_fracs = parse_composition(molefraction,gasphase)
        return mole_fracs
    end
end

"""
Function for creating the headers in the output file 
# Usage:
create_header(file_stream, args...)    
-   file_stream: output file stram 
-   args... : variable arguments, which are headers 
"""
function create_header(file_stream, args...)
    for i in eachindex(args)
        for k in args[i]
            @printf(file_stream,"%10s\t",k)
        end
    end
    @printf(file_stream,"\n")
end

"""
Function for writing data in the output file 
# Usage:
write_to_file(file_stream, args...)    
-   file_stream: output file stream
-   args... : variable arguments, which is the floating point data
"""
function write_to_file(file_stream, args...)
    for i in eachindex(args)
        for k in args[i]
            @printf(file_stream,"%.4e\t",k)
        end
    end
    @printf(file_stream,"\n")
end

"""
Function for creating the headers in the output CSV file 
# Usage:
create_header(file_stream, args...)    
-   file_stream: output file stram 
-   args... : variable arguments, which are headers 
"""
#= function create_csv_header(file_stream, args...)
    write_csv_file(file_stream, args...)
end
 =#
"""
Function for writing data in CSV format
# Usage:
write_to_file(file_stream, args...)    
-   file_stream: output file stram 
-   args... : variable arguments, whichis the data
"""

#= function write_csv_file(file_stream, args...)
    data = Array{String,1}()
    for i in eachindex(args)
        push!(data, string(args[i]))
    end    
    @printf(file_stream, "%s", join(data, ","))    
    @printf(file_stream, "\n")
end
 =#

"""
Function for writing data in the csv file format
# Usage:
write_csv(file_stream, data)    
-   file_stream: output file stream
-   data : Vector of strings
"""
function write_csv(file_stream, data::Array{String,1})
    @printf(file_stream, "%s", join(data, ","))
    @printf(file_stream, "\n")
end

"""
Function for writing data in the csv file format
# Usage:
write_csv(file_stream, data)    
-   file_stream: output file stream
-   data : Vector of Float64
"""
function write_csv(file_stream, data::Vector{Float64})
    sdata = string.(data)
    write_csv(file_stream, sdata)
end

"""
Function for writing data in the csv file format
# Usage:
write_csv(file_stream, data)    
-   file_stream: output file stream
-   data : Vector of Float64, String, or Int64
"""
function write_csv(file_stream, data::Array{T,1}) where T <: Union{Float64, String, Int64}
    sdata = string.(data)
    write_csv(file_stream, sdata)
end

"""
Function for writing data in the csv file format
# Usage:
write_csv(file_stream, data)    
-   file_stream: output file stream
-   args... : any mix of arguments
"""
function write_csv(file_stream, args...)
    if length(args) == 1
        write_csv(file_stream, string.(args[1]))
    else
        data = Array{String,1}()
        for i in eachindex(args)
            if typeof(args[i]) == String || typeof(args[i]) == Float64 || typeof(args[i]) == Int64
                push!(data, string(args[i]))
            else
                for k in args[i]
                    push!(data, string(k))
                end
            end
        end
        write_csv(file_stream, data)
    end
end

end
