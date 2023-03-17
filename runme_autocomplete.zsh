#compdef _lscpu lscpu

function _lscpu {
    local line

    _arguments -C \
        "-h[Show help information]" \
        "--h[Show help information]" \
        "1: :(quietly loudly)" \
        "*::arg:->args"

    case $line[1] in
        loudly)
            _lscpu_loudly
        ;;
        quietly)
            _lscpu_quietly
        ;;
    esac
}

function _lscpu_quietly {
    _arguments \
        "--silent[Dont output anything]"
}

function _lscpu_loudly {
    _arguments \
        "--repeat=[Repat the <message> any number of times]"
}

