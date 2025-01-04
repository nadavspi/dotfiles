function check-bitdepth
    for file in *.flac
        echo -n "$file: "
        ffprobe -v error -select_streams a:0 -show_entries stream=bits_per_raw_sample -of default=noprint_wrappers=1:nokey=1 "$file"
    end
end
