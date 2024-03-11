function extract_embedded_xml_from_svg {
  xmllint --xpath 'string(/*/@content)' -
}

export -f extract_embedded_xml_from_svg


function extract_payload_from_mxfile {
  local file
  file="${1?}"
  xmllint --xpath '/mxfile/diagram/text()' "${file}"
}

export -f extract_payload_from_mxfile


function strip_doctype {
  local file
  file="${1?}"
  sed -e '/^<!DOCTYPE/d' "${file}"
}

export -f strip_doctype
