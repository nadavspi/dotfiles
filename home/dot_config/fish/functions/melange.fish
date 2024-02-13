function melange --wraps='podman run --rm cgr.dev/chainguard/melange' --description 'alias melange=podman run --rm cgr.dev/chainguard/melange'
  podman run --rm cgr.dev/chainguard/melange $argv
        
end
