#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

while true; do
    PID=$(pidof swaybg)
    swaybg -c "#313244" -i "$(find /usr/share/wallpapers/ -type f | shuf -n1)" -m fit &
    sleep 1
    # shellcheck disable=SC2086
    kill $PID
    sleep 21600
done
