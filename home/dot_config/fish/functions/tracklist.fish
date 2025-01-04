function tracklist
    # Show album name without metadata in brackets
    pwd | sed 's/.*\///' | sed 's/ \[.*//'
    
    # Process each flac file
    for f in *.flac
        # Get duration in seconds
        set duration (ffprobe -v quiet -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$f")
        
        # Convert duration to minutes:seconds
        set minutes (math floor "$duration / 60")
        set seconds (math round "$duration % 60")
        
        # Format seconds with leading zero if needed
        set seconds (string pad -c 0 -w 2 "$seconds")
        
        # Print track with duration
        printf " %s (%d:%s)\n" (echo "$f" | sed 's/\.flac//') $minutes $seconds
    end
end
