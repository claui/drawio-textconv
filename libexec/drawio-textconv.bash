source libexec/options.bash

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
    sed -e '/^<!DOCTYPE/d' "${file}" \
      | xmllint --xpath '/mxfile/diagram/text()' - \
      | base64 --decode \
      | bash -c 'cat <(
        /usr/bin/xxd -r -p <<< "1f 8b 08 08 d1 ee 75 58 00 03 63 6f 6e 74 65 6e 74 2e 62 61 73 65 36 34 00"
      ) -' \
      | gunzip 2>/dev/null \
      | ruby -rcgi -pe '$_ = CGI::unescape($_)' \
      | xsltproc "${post_processor}" || true
  elif [[ "${option}" == 'uncompressed' ]]; then
    sed -e '/^<!DOCTYPE/d' "${file}" \
      | if [ "$(xmllint --xpath '/mxfile/diagram/text()' "${file}" | head -c 1)" ]; then
        echo >&2 'drawio textconv: unable to decode unknown binary diagram format'; exit 1;
      else
        xsltproc "${post_processor}" - || true
      fi
  elif [[ "${option}" == 'svg' ]]; then
    # shellcheck disable=SC2016
    sed -e '/^<!DOCTYPE/d' "${file}" \
      | xmllint --xpath 'string(/*/@content)' - \
      | xmllint --xpath '/mxfile/diagram/text()' - \
      | base64 --decode \
      | bash -c 'cat <(
        /usr/bin/xxd -r -p <<< "1f 8b 08 08 d1 ee 75 58 00 03 63 6f 6e 74 65 6e 74 2e 62 61 73 65 36 34 00"
      ) -' \
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
