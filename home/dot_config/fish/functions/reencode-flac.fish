function reencode-flac
    mkdir -p originals
    for file in *.flac
        if test -f "$file"
            mv "$file" "originals/$file"
            ffmpeg -i "originals/$file" -c:a flac -compression_level 8 "$file"
        end
    end
end
