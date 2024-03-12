source libexec/version.bash

function parse_options {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -c|--compressed)
        _set_option 'compressed'
        shift
        ;;
      -u|--uncompressed)
        _set_option 'uncompressed'
        shift
        ;;
      -s|--svg)
        _set_option 'svg'
        shift
        ;;
      -V|--version)
        echo >&2 "${BASENAME} v${__VERSION}"
        exit 0
        ;;
      -)
        _set_file "${1}"
        shift
        ;;
      -*)
        echo >&2 "Error: Unknown option ${1}"
        return 1
        ;;
      *)
        _set_file "${1}"
        shift
        ;;
    esac
  done

  if [[ -z "${option:-}" ]]; then
    echo "Error: Exactly one of -c/--compressed, -u/--uncompressed,`
      ` or -s/--svg must be provided."
    return 1
  fi

  # Hint for shellcheck
  export file option
}

export -f parse_options


_assert_unset() {
  local param description
  param="${1?}"
  description="${2?}"

  if [[ -n "${param}" ]]; then
    printf >&2 'Error: More than one %s provided.\n' "${description}"
    return 1
  fi
}

export -f _assert_unset


function _set_file {
  local value
  value="${1?}"

  _assert_unset "${file:-}" 'file parameter'
  file="${value}"
}

export -f _set_file


function _set_option {
  local value
  value="${1?}"

  _assert_unset "${option:-}" 'option'
  option="${value}"
}

export -f _set_option
