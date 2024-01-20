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

if [[ ${#} == 0 ]]; then
    help 0;
    exit 1;
fi

case ${1} in
    "help" | "--help" | "-h" )
        help
        exit 0
        ;;
    hello )
        $1 "${@:2}"
        ;;
    * )
        echo "unknown command: $1";
        help 1;
        exit 1;
        ;;
esac
