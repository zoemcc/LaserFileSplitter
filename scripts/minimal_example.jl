using LaserFileSplitter

svgfile = "data/exp_raw/DeathMoonDevil.svg"
outfolder = "data/processed/chunked_deathmoondevil3"
max_num_chunks = 10
save_svg_in_chunks(svgfile, outfolder, max_num_chunks)

