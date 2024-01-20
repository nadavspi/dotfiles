#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

caller=$(basename "$0")

help() {
    echo "Usage: $caller <subcommand> [options]"
    echo "Subcommands:"
    echo "  hello  says hi to you"
    echo ""
    echo "For help with each subcommand run:"
    echo "$caller <subcommand> -h|--help"
    echo ""
}

hello() {
		echo "hi"
}

subcommand=$1
case $subcommand in
"" | "help" | "-h" | "--help")
    help
    ;;
*)
    shift
    ${subcommand} "$@"
    if [ $? = 127 ]; then
        echo "Error: '$subcommand' is not a known subcommand." >&2
        echo "  Run '$caller --help' for a list of known subcommands." >&2
        exit 1
    fi
    ;;
esac
