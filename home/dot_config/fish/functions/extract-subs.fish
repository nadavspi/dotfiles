function extract-subs
    # If no arguments, use fzf
    if test (count $argv) -eq 0
        set vidpaths (fzf -m)
    else
        set vidpaths $argv
    end
    
    if test (count $vidpaths) -eq 0
        set_color red
        echo "No files selected. Exiting."
        set_color normal
        exit
    end
    
    for vidpath in $vidpaths
        # Verify the file exists and is readable
        if not test -f "$vidpath"
            set_color yellow
            echo "Warning: File not found or not readable: $vidpath"
            set_color normal
            continue
        end
        
        # streams in csv: idx,lang,title
        set subs (ffprobe -v 8 -hide_banner -select_streams s \
            -show_entries "stream=index:stream_tags=language,title" \
            -of "csv=p=0" "$vidpath")
        
        if [ -z "$subs" ]
            set_color yellow
            echo "Warning: No subtitles found in file: $vidpath"
            set_color normal
            continue
        end
        
        set_color green
        echo "📄 Extracting subtitles from: $vidpath"
        set_color normal
        
        for stream in $subs
            set idx (string split -f1 ',' $stream)
            set lang (string split -f2 ',' $stream)
            set title (string split -f3 ',' $stream)
            
            # Sanitize title to lowercase and remove spaces
            set clean_title (string lower (string replace -ar '[^a-zA-Z0-9-]' '' "$title"))
            
            # If no title, skip adding it
            if [ -z "$clean_title" ]
                set subfile (string replace -r '\.(.{3})$' ".$lang.srt" $vidpath)
            else
                set subfile (string replace -r '\.(.{3})$' ".$clean_title.$lang.srt" $vidpath)
            end
            
            # Check if subtitle file already exists
            if test -f "$subfile"
                set_color yellow
                echo "  ⚠️ Skipping $subfile (file already exists)"
                set_color normal
                continue
            end
            
            set_color blue
            echo "  🔍 Extracting subtitle stream $idx ($clean_title.$lang):"
            set_color normal
            
            # Show ffmpeg output directly to the user
            ffmpeg -y -hide_banner -i "$vidpath" -map 0:$idx "$subfile"
            
            # Check ffmpeg exit status
            if test $status -eq 0
                set_color green
                echo "  ✅ Successfully extracted: $subfile"
                set_color normal
            else
                set_color red
                echo "  ❌ Failed to extract subtitle stream $idx"
                set_color normal
            end
        end
    end
    
    set_color yellow
    echo "🏁 Subtitle extraction complete!"
    set_color normal
end
