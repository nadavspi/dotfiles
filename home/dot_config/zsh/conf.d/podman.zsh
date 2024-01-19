function pi () {
  podman inspect $1 | jq '.[0].Config.Labels'
}
