function generate-spectrograms
    # Create the spectrograms directory in the current folder
    mkdir -p spectrograms

    # Iterate over all .flac files in the current directory
    for file in *.flac
        # Check if the file exists (in case no .flac files are present)
        if test -e "$file"
            # Extract the base filename without path
            set base_filename (basename -- "$file")

            # Remove leading and trailing quotes and escape special characters in the filename
            set clean_filename (string trim -- ' ' "$base_filename" | string replace -- "'" "")

            # Generate full spectrogram
            sox "$file" -n remix 1 spectrogram -x 3000 -y 513 -z 120 -w Kaiser -o "spectrograms/$clean_filename-full.png"

            # Generate zoomed spectrogram
            sox "$file" -n remix 1 spectrogram -X 500 -y 1025 -z 120 -w Kaiser -S 1:00 -d 0:02 -o "spectrograms/$clean_filename-zoom.png"
        end
    end
end
