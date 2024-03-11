source libexec/options.bash
source libexec/xml.bash
source libexec/zip.bash

function __drawio_textconv {
  local file option

  parse_options "$@"

  if [[ -z "${file:-}" ]]; then
    file='-'
  fi

  post_processor=~/.local/share/stylesheets/git-textconv-drawio-mxfile-min.xml

  if [[ ! -e "${post_processor}" ]]; then
    echo >&2 "Error: File ${post_processor} not found"
    return 1
  fi

  if [[ "${option}" == 'compressed' ]]; then
    # shellcheck disable=SC2016
    strip_doctype "${file}" \
      | extract_payload_from_mxfile - \
      | base64 --decode \
      | prepend_zip_header \
      | gunzip 2>/dev/null \
      | ruby -rcgi -pe '$_ = CGI::unescape($_)' \
      | xsltproc "${post_processor}" || true
  elif [[ "${option}" == 'uncompressed' ]]; then
    strip_doctype "${file}" \
      | if [[ "$(extract_payload_from_mxfile "${file}" | head -c 1)" ]]; then
        echo >&2 'drawio textconv: unable to decode unknown binary diagram format'; exit 1;
      else
        xsltproc "${post_processor}" - || true
      fi
  elif [[ "${option}" == 'svg' ]]; then
    # shellcheck disable=SC2016
    strip_doctype "${file}" \
      | extract_embedded_xml_from_svg \
      | extract_payload_from_mxfile - \
      | base64 --decode \
      | prepend_zip_header \
      | gunzip 2>/dev/null \
      | ruby -rcgi -pe '$_ = CGI::unescape($_)' \
      | xsltproc "${post_processor}" - || true
  else
    printf >&2 \
      'Internal error: Missing implementation for option %s\n' \
      "${option}"
    return 1
  fi
}

export -f __drawio_textconv
