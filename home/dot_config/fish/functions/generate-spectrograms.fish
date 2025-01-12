function generate-spectrograms
    # Define and parse arguments
    argparse 'zoom=' -- $argv
    or return

    # Create the spectrograms directory in the current folder
    mkdir -p spectrograms

    # Handle --zoom flag case
    if set -q _flag_zoom
        # Check if a file was provided
        if test (count $argv) -eq 0
            echo "Error: Please provide a file when using --zoom"
            return 1
        end
        
        set file $argv[1]
        if test -e "$file"
            set base_filename (basename -- "$file")
            set clean_filename (string trim -- ' ' "$base_filename" | string replace -- "'" "")
            
            # Clean up start time for filename (replace : with -)
            set time_for_filename (string replace ':' '-' $_flag_zoom)
            
            # Generate only the zoomed spectrogram for the specified file
            sox "$file" -n remix 1 spectrogram -X 500 -y 1025 -z 120 -w Kaiser \
                -S "$_flag_zoom" -d 0:02 \
                -o "spectrograms/$clean_filename-zoom-$time_for_filename.png" \
                -t "$file (zoom start: $_flag_zoom)"
        else
            echo "Error: File '$file' not found"
            return 1
        end
        return
    end

    # Default behavior (no --zoom flag): process all .flac files
    for file in *.flac
        if test -e "$file"
            set base_filename (basename -- "$file")
            set clean_filename (string trim -- ' ' "$base_filename" | string replace -- "'" "")
            
            # Generate full spectrogram
            sox "$file" -n remix 1 spectrogram -x 3000 -y 513 -z 120 -w Kaiser \
                -o "spectrograms/$clean_filename-full.png" -t "$file"
            
            # Generate zoomed spectrogram with default start time
            sox "$file" -n remix 1 spectrogram -X 500 -y 1025 -z 120 -w Kaiser \
                -S 1:00 -d 0:02 \
                -o "spectrograms/$clean_filename-zoom.png" \
                -t "$file (zoom start: 1:00)"
        end
    end
end
