#!/usr/bin/env bash

usage() {
cat <<EOF

Script to bootstrap and manage go workspaces.

usage: $0 [-p]

OPTIONS:
  -p Path to go workspace. If specified path doesn't exist, a new
workspace is created. Otherwise, workspace at the specified is made
current.
  -h Help. Prints this message.

EOF
}

_DEFAULT_WORKSPACE="~/goworkspace"

GO_WORKSPACE=$_DEFAULT_WORKSPACE

while getopts "p:h" OPTION
do
    case $OPTION in
	p)
	    export GO_WORKSPACE=$OPTARG
	    ;;
	h)
	    usage
	    exit
	    ;;
	?)
	    usage
	    exit
	    ;;
    esac
done

ERROR() {
    local msg="$1"
    local error_code="$2"
    local error_handler="$3"

    echo -e "E " "${msg}" >&2
    if [ -n "${error_handler}" ]; then
	eval ${error_handler}
    fi

    if [ -n "${error_code}" ]; then
	exit ${error_code}
    fi
}

shift $(($OPTIND - 1))
# $1 is now the first non-option argument, $2 the second etc
CMD="$@"

MODE="switch"

if [ -z "${GO_WORKSPACE}" ]; then
    ERROR "Missing input argument" -1 usage
fi

if [ ! -d "${GO_WORKSPACE}" ]; then
    MODE="create"
fi

_create_directories() {
    for d in "src pkg bin"
    do
	echo "Creating directory: ${GO_WORKSPACE}/${d}"
	mkdir -p "${GO_WORKSPACE}/${d}"
    done
}

_export_vars() {
    echo "# Added by gobootstrap"
    echo "export GOPATH=${GO_WORKSPACE}" >> ~/.profile
    echo "export PATH=${PATH}:${GO_WORKSPACE}/bin" >> ~/.profile
}

create_workspace() {
    # Create directories
    _create_directories

    # Set environment variables
    _export_vars
}

switch_workspace() {

}

if [ "x${MODE}" = "xcreate" ]; then
    create_workspace
elif [ "x${MODE}" = "xswitch" ]; then
    switch_workspace
fi
