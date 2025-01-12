function read_secret --argument-names path description
    set -l value (op read $path)
    or begin
        echo "Failed to read $description from 1password" >&2
        return 1
    end
    if test -z "$value"
        echo "Error: Empty value for $description" >&2
        return 1
    end
    echo $value
end

function seedbox-upload --description 'Upload files to seedbox using rsync' --argument dry_run
    # Read secrets from 1password and validate they're not empty
    set -l target_host (read_secret "op://Personal/Ultra.cc seedbox/Seedbox/hostname" "hostname")
    or return 1
    
    set -l username (read_secret "op://Personal/Ultra.cc seedbox/Seedbox/username" "username")
    or return 1
    
    set -l path_local_upload (read_secret "op://Personal/Ultra.cc seedbox/rsync/local upload path" "local upload path")
    or return 1
    
    set -l path_files (read_secret "op://Personal/Ultra.cc seedbox/rsync/files path" "files path")
    or return 1
    
    set -l path_watch (read_secret "op://Personal/Ultra.cc seedbox/rsync/watch path" "watch path")
    or return 1

    # Validate local upload path exists
    if not test -d "$path_local_upload"
        echo "Error: Local upload directory '$path_local_upload' does not exist" >&2
        return 1
    end
    
    # Construct remote host string
    set -l remote_host "$username@$target_host"
    
    # Set rsync base options
    set -l rsync_opts -avz --progress
    if test "$dry_run" = "--dry-run"
        set -a rsync_opts --dry-run
        echo "Running in dry-run mode - no files will be transferred"
    end

    # Upload directories to files path
    echo "Uploading directories to $path_files..."
    rsync $rsync_opts \
        --include='*/' \
        --include='*/**' \
        --exclude='*' \
        "$path_local_upload/" \
        "$remote_host:$path_files/"
    or begin
        echo "Error: Failed to upload directories" >&2
        return 1
    end
    
    # Upload torrent files to watch directory
    echo "Uploading torrent files to $path_watch..."
    rsync $rsync_opts \
        --include='*.torrent' \
        --exclude='*' \
        "$path_local_upload/" \
        "$remote_host:$path_watch/"
    or begin
        echo "Error: Failed to upload torrent files" >&2
        return 1
    end
    
    echo "Upload completed successfully"
end
