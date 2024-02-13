function apko --wraps='podman run --rm cgr.dev/chainguard/apko' --description 'alias apko=podman run --rm cgr.dev/chainguard/apko'
  podman run --rm cgr.dev/chainguard/apko $argv
        
end
