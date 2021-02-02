using EzXML
using LaserFileSplitter


svgfile = "data/exp_raw/DeathMoonDevil.svg"

begin
    svgdoc = readxml(svgfile);
    svgfile
end

begin
    elms = collect(eachelement(root(svgdoc)))
    svgfile
end

exnode = elms[1000]

exnode["class"]

elements_with_class = [node for node in elms if haskey(node, "class")]

classes = Set(node["class"] for node in elements_with_class)
classes_nodedict = Dict{String, Vector{EzXML.Node}}(class=>[] for class in classes)

for elm in elements_with_class
    push!(classes_nodedict[elm["class"]], elm)
end

class_lengths = length.(values(classes_nodedict))
sorted_class_lengths = sort(class_lengths)

exnode["d"]

#named_elms = filter(n->haskey(n, "name"), elms)
paths = [node for node in elms if node.name == "path"]
paths = filter(n->n.name == "path", elms)

#write(datadir("processed/DeathMoonDevil_same.svg"), svgdoc)

EzXML.parentelement(elms[100])

parents = Set(EzXML.parentelement.(elms))

EzXML.nodename(elms[100])

collect(eachattribute(root(svgdoc)))
nodetype.(elms)


k = 1
splitby = 2000

for i in 2001:length(paths)
    unlink!(paths[i])
end
#for i in 1:2000
    #unlink!(paths[i])
#end

#for i 

num_per_chunk = 1000

filename = svgfile
outfolder = "data/processed/chunked_deathmoondevil2"
max_num_chunks = 10
save_svg_in_chunks(filename, outfolder, max_num_chunks)




newelms = collect(eachelement(root(svgdoc)))


write(datadir("processed/DeathMoonDevil_fewpaths_0.svg"), svgdoc)

for i in 2001:length(paths)
    link!(root(svgdoc), paths[i])
end

write(datadir("processed/DeathMoonDevil_shouldbesame.svg"), svgdoc)
