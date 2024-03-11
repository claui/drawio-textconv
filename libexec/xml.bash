function strip_doctype {
  local file
  file="${1?}"
  sed -e '/^<!DOCTYPE/d' "${file}"
}

export -f strip_doctype
