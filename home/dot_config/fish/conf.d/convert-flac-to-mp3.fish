function convert-flac-to-mp3 -d "Convert FLAC album to MP3 V0 and 320 formats"
    # Check if source directory is provided
    if test (count $argv) -ne 1
        echo "Usage: convert-flac-to-mp3 <source_directory>"
        return 1
    end
    # Source directory from command line argument
    set SOURCE_DIR $argv[1]
    # Check if source directory exists
    if not test -d $SOURCE_DIR
        echo "Error: Directory '$SOURCE_DIR' not found"
        return 1
    end
    # Validate that it's a FLAC source
    if not string match -q "*FLAC]*" $SOURCE_DIR
        echo "Error: Source directory must be a FLAC source (must contain '[FLAC]' or '[XXX, FLAC]')"
        return 1
    end
    # Get the directory name without the format tag, trimming extra spaces
    set BASE_PATH (dirname $SOURCE_DIR)/(string replace -r '\s*\[([^]]*)\]\s*$' '' (basename $SOURCE_DIR) | string trim)
    # Extract everything inside the square brackets
    set TAGS (string match -r '\[([^]]*)\]' (basename $SOURCE_DIR))
    set INSIDE_BRACKETS $TAGS[2]
    # Function to replace FLAC with new format while preserving other tags
    function replace_format
        set format $argv[1]
        # Split the tags by comma and trim whitespace
        set tag_list (string split ',' $INSIDE_BRACKETS | string trim)
        # Find and replace FLAC with the new format
        set new_tags
        for tag in $tag_list
            if test "$tag" = "FLAC"
                set -a new_tags $format
            else
                set -a new_tags $tag
            end
        end
        # Join the tags back together with commas
        string join ', ' $new_tags
    end
    # Create the new directory names with preserved tags
    set V0_DIR "$BASE_PATH [((replace_format 'MP3 V0'))]"
    set CBR_DIR "$BASE_PATH [((replace_format 'MP3 320'))]"
    
    # Create target directories if they don't exist
    mkdir -p "$V0_DIR"
    mkdir -p "$CBR_DIR"
    # Process each file in the source directory
    for file in $SOURCE_DIR/*
        # Get just the filename without the path
        set filename (basename $file)
        
        # If it's a FLAC file
        if string match -q "*.flac" $filename
            # Remove the .flac extension for the new MP3 filename
            set basename (string replace -r '\.flac$' '' $filename)
            
            # Convert to MP3 V0
            ffmpeg -i "$file" -codec:a libmp3lame -q:a 0 "$V0_DIR/$basename.mp3"
            
            # Convert to MP3 320 CBR
            ffmpeg -i "$file" -codec:a libmp3lame -b:a 320k "$CBR_DIR/$basename.mp3"
        else
            # Copy non-FLAC files to both directories
            cp "$file" "$V0_DIR/"
            cp "$file" "$CBR_DIR/"
        end
    end
    echo "Conversion complete!"
    return 0
end
