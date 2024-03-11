source libexec/constants.bash
source libexec/options.bash
source libexec/xml.bash
source libexec/zip.bash

function __drawio_textconv {
  local file option

  parse_options "$@"

  if [[ -z "${file:-}" ]]; then
    file='-'
  fi

  post_processor="${__PROJECT_ROOT}/${__POST_PROCESSOR}"

  if [[ ! -e "${post_processor}" ]]; then
    echo >&2 "Error: File ${post_processor} not found"
    return 1
  fi

  if [[ "${option}" == 'uncompressed' ]]; then
    _extract_uncompressed_xml "${file}"
  fi

  # shellcheck disable=SC2016
  if [[ "${option}" == 'compressed' ]]; then
    strip_doctype "${file}"
  elif [[ "${option}" == 'svg' ]]; then
    strip_doctype "${file}" | extract_embedded_xml_from_svg
  else
    printf >&2 'Internal error: Missing implementation for option %s\n' \
      "${option}"
    return 1
  fi \
    | extract_payload_from_mxfile - \
    | base64 --decode \
    | prepend_zip_header \
    | { gunzip 2>/dev/null || true; } \
    | ruby -rcgi -pe '$_ = CGI.unescape($_)' - \
    | xsltproc "${post_processor}" -
}

export -f __drawio_textconv

function _extract_uncompressed_xml {
  local file
  file="${1?}"

  strip_doctype "${file}" \
    | if [[ "$(extract_payload_from_mxfile "${file}" | head -c 1)" ]]; then
      echo >&2 'drawio textconv: unable to decode unknown binary diagram format'; exit 1;
    else
      xsltproc "${post_processor}" -
    fi
  return 0
}

export -f _extract_uncompressed_xml
