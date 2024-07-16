var documenterSearchIndex = {"docs":
[{"location":"","page":"Home","title":"Home","text":"CurrentModule = RxnHelperUtils","category":"page"},{"location":"#RxnHelperUtils","page":"Home","title":"RxnHelperUtils","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Documentation for RxnHelperUtils.","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"Modules = [RxnHelperUtils]","category":"page"},{"location":"#RxnHelperUtils.average_molwt-Union{Tuple{T}, Tuple{T, T}} where T","page":"Home","title":"RxnHelperUtils.average_molwt","text":"Function for calculating the average molecular weight\n\nUsage:\n\naverage_molwt(molfracs,molwt)\n\nmolfracs::Array{Float64,1} : vector of mole fraction \nmolwt::Array{Float64,1} :    vector of molecular weights \n\n\n\n\n\n","category":"method"},{"location":"#RxnHelperUtils.convert2si-Tuple{String}","page":"Home","title":"RxnHelperUtils.convert2si","text":"Function for converting any unit to SI unit.\n\nUsage:\n\nconvert2si(u::String)     The function will return the corresponding value in SI units \n\n\n\n\n\n","category":"method"},{"location":"#RxnHelperUtils.create_csv_header-Tuple{Any, Vararg{Any}}","page":"Home","title":"RxnHelperUtils.create_csv_header","text":"Function for creating the headers in the output CSV file \n\nUsage:\n\ncreateheader(filestream, args...)    \n\nfile_stream: output file stram \nargs... : variable arguments, which are headers \n\n\n\n\n\n","category":"method"},{"location":"#RxnHelperUtils.create_header-Tuple{Any, Vararg{Any}}","page":"Home","title":"RxnHelperUtils.create_header","text":"Function for creating the headers in the output file \n\nUsage:\n\ncreateheader(filestream, args...)    \n\nfile_stream: output file stram \nargs... : variable arguments, which are headers \n\n\n\n\n\n","category":"method"},{"location":"#RxnHelperUtils.density-Union{Tuple{T1}, Tuple{T1, T1, T1}} where T1","page":"Home","title":"RxnHelperUtils.density","text":"Function for the calculation of density \n\nUsage\n\ndensity(avg_molwt, T, p)    \n\navg_molwt : average molecular weight\nT : temperature in K \np : pressure in Pa \n\n\n\n\n\n","category":"method"},{"location":"#RxnHelperUtils.get_collection_from_xml-Tuple{LightXML.XMLElement, String}","page":"Home","title":"RxnHelperUtils.get_collection_from_xml","text":"Function to get vector of strings contained in a tag. Ideal for getting the species names \n\nUsage:\n\ngetcollectionfrom_xml(xmlroot,tag)\n\nxmlroot::XMLElement : The xml root node\ntag::String : name of the tag\n\nThe function returns vector of strings. \n\n\n\n\n\n","category":"method"},{"location":"#RxnHelperUtils.get_index-Tuple{String, Vector{String}}","page":"Home","title":"RxnHelperUtils.get_index","text":"getindex(sp,ig) Get the index of species in the gasphase limits #Usage getindex(sp,ig)\n\nsp::String : species name\nsp_list::Array{String,1}  : Array of species names \n\n\n\n\n\n","category":"method"},{"location":"#RxnHelperUtils.get_molefraction_from_xml-Tuple{LightXML.XMLElement, Array{Float64}, Vector{String}}","page":"Home","title":"RxnHelperUtils.get_molefraction_from_xml","text":"Function to get the mole fractions of species\n\nUsage:\n\ngetmolefractionfrom_xml(xmlroot,molwt,gasphase)\n\nxmlroot::XMLElement : The xml root node\nmolwt::Array{Float64} :  Vector of molecular weights\n\n\n\n\n\n","category":"method"},{"location":"#RxnHelperUtils.get_path-Tuple{String, String}","page":"Home","title":"RxnHelperUtils.get_path","text":"function for constructing relative path to a file #Usage:     getpath(path::String, filename::String)\n\n\n\n\n\n","category":"method"},{"location":"#RxnHelperUtils.get_text_from_xml-Tuple{LightXML.XMLElement, String}","page":"Home","title":"RxnHelperUtils.get_text_from_xml","text":"Function to get the file path from an xml tag\n\nUsage:\n\ngettextfrom_xml(xmlroot,tag)\n\nxmlroot::XMLElement : The xml root node\ntag::String : name of the tag\n\nThe function returns string of file path\n\n\n\n\n\n","category":"method"},{"location":"#RxnHelperUtils.get_value_from_xml-Tuple{LightXML.XMLElement, String}","page":"Home","title":"RxnHelperUtils.get_value_from_xml","text":"Function to get floating point value from an  xml tag\n\nUsage:\n\ngetvaluefrom_xml(xmlroot,tag)\n\nxmlroot::XMLElement : The xml root node\ntag::String : name of the tag\n\nThe function returns the floating point value contained in the tag\n\n\n\n\n\n","category":"method"},{"location":"#RxnHelperUtils.massfrac_to_molefrac!-Union{Tuple{T}, Tuple{T, T, T}} where T<:Vector{Float64}","page":"Home","title":"RxnHelperUtils.massfrac_to_molefrac!","text":"Function to convert massfractions to mole fractions\n\nUsage:\n\nmassfrac_to_molefrac!(massfracs,mol_wt,molefracs)\n\nmassfracs::Array{Float64,1} : Vector of massfractions\nmol_wt::Array{Float64,1} : Vector of molecular weights\nmolefracs::Array{Float64,1} : Vector of molefractions \n\n\n\n\n\n","category":"method"},{"location":"#RxnHelperUtils.massfrac_to_molefrac-Union{Tuple{T}, Tuple{T, T}} where T<:Vector{Float64}","page":"Home","title":"RxnHelperUtils.massfrac_to_molefrac","text":"Function to convert massfractions to mole fractions\n\nUsage:\n\nmassfractomolefrac(massfracs,mol_wt,molefracs)\n\nmassfracs::Array{Float64,1} : Vector of massfractions\nmol_wt::Array{Float64,1} : Vector of molecular weights\n\n\n\n\n\n","category":"method"},{"location":"#RxnHelperUtils.molefrac_to_massfrac!-Union{Tuple{T}, Tuple{T, T, T}} where T<:Vector{Float64}","page":"Home","title":"RxnHelperUtils.molefrac_to_massfrac!","text":"Function to convert molefractions to massfractions\n\nUsage:\n\nmolefrac_to_massfrac!(massfracs,molefracs,mol_wt)\n\nmolefracs::Array{Float64,1} : Vector of molefractions\nmol_wt::Array{Float64,1} : Vector of molecular weights\n\n\n\n\n\n","category":"method"},{"location":"#RxnHelperUtils.output_file-Tuple{String, String}","page":"Home","title":"RxnHelperUtils.output_file","text":"Function for creating path to the output file\n\nUsage\n\noutputfile(inputfile::String, output_file::String)\n\ninput_file::String : input file including the path specification\noutput_file::String : output file including path specification\n\nThe output file will be placed in the same location as that of the  input file. This function finds the location of the input file,  constructs the path based on the input file location \n\n\n\n\n\n","category":"method"},{"location":"#RxnHelperUtils.parse_composition-Tuple{String, Vector{String}}","page":"Home","title":"RxnHelperUtils.parse_composition","text":"Function to parse the composition string\n\nUsage:\n\nparse_composition(composition_data,sp_list)\n\ncomposition_data::String : composition specification String\nsp_list:Array{String,1}: Array of species names\n\n\n\n\n\n","category":"method"}]
}
