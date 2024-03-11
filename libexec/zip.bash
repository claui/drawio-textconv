source libexec/constants.bash

function prepend_zip_header {
  cat <(/usr/bin/xxd -r -p <<< "${__ZIP_HEADER_HEX}") -
}

export -f prepend_zip_header
