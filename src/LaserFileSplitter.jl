module LaserFileSplitter

using EzXML

function save_svg_in_chunks(filename::AbstractString, outfolder::AbstractString, max_num_chunks::Integer)
    svgdoc = readxml(filename);
    elms = collect(eachelement(root(svgdoc)))
    paths = filter(n->n.name == "path", elms)

    mkdir(outfolder)


    for num_chunks in 1:max_num_chunks

        chunk_folder = outfolder*"/$(num_chunks)_chunks"
        mkdir(chunk_folder)

        num_per_chunk = Int(ceil(length(paths) // num_chunks))
        chunked_paths = [paths[1 + (k-1)*num_per_chunk:k*num_per_chunk] for k in 1:num_chunks-1]
        push!(chunked_paths, paths[1 + (num_chunks-1)*num_per_chunk:end])

        @assert(sum(length.(chunked_paths))==length(paths))

        for k in 1:num_chunks
            # delete all other paths
            for i in 1:num_chunks
                if i != k
                    unlink!.(chunked_paths[i])
                end
            end

            # save chunk
            write(chunk_folder*"/$(num_chunks)_$(k).svg", svgdoc)

            # add back all other paths
            for i in 1:num_chunks
                if i != k
                    for path in chunked_paths[i]
                        link!(root(svgdoc), path)
                    end
                end
            end

        end
    end
    true
end

export save_svg_in_chunks

end
